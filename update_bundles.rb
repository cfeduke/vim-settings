#!/usr/bin/env ruby

git_bundles = [ 
  #"git://github.com/msanders/snipmate.vim.git",
	#use wycats modified janus nerdtree
	"git://github.com/wycats/nerdtree.git",  
  "git://github.com/tpope/vim-fugitive.git",
  #"git://github.com/tpope/vim-rails.git",
  "git://github.com/tpope/vim-repeat.git",
  "git://github.com/tpope/vim-surround.git",
  "git://github.com/vim-ruby/vim-ruby.git",
	"git://github.com/altercation/vim-colors-solarized.git",
	#"git://github.com/cfeduke/snipmate.vim.git",
  #"git://github.com/jeffkreeftmeijer/vim-numbertoggle.git",
  "git://github.com/scrooloose/nerdcommenter.git",
  "git://github.com/mileszs/ack.vim.git",
  "git://github.com/vim-scripts/YankRing.vim.git",
  #"git://github.com/claco/jasmine.vim.git",
	"git://github.com/docunext/closetag.vim.git",
  #"git://github.com/wincent/Command-T.git",
  "git://github.com/sjl/gundo.vim.git",
  "git://github.com/godlygeek/tabular.git",
  "git://github.com/Lokaltog/vim-easymotion.git",
  #"git://github.com/vim-scripts/vim-creole.git",
  #"git://github.com/sebastiangeiger/sweet-rspec-vim.git",
  "git://github.com/Valloric/YouCompleteMe.git",
  #"git://github.com/vim-scripts/VimClojure.git",
  "git://github.com/derekwyatt/vim-sbt.git",
  "git://github.com/elixir-lang/vim-elixir.git",
]

vim_org_scripts = [
  ["gist",          "15452", "plugin"],
  ["jquery",        "12276", "syntax"],
  ["fuzzyfinder",   "13961",   "zip"],
  ["l9",  					"13948",   "zip"],
  ["copy-as-rtf",   "19851",   "tar"],
]

other_scripts = [
]


require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

def make_local_file_name(name, script_type)
  File.join(name, script_type, "#{name}.#{['tar', 'zip', 'tgz'].include?(script_type) ? script_type : 'vim'}")
end

FileUtils.cd(bundles_dir)

puts "Trashing everything (lookout!)"
Dir["*"].each {|d| FileUtils.rm_rf d }

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '')
  if Dir.exist?("#{dir}/.git")
    puts "  Updating #{dir}"
    %x(cd #{dir} ; git pull origin master)
  else
    puts "  Unpacking #{url} into #{dir}"
    `git clone #{url} #{dir}`
  end
  #FileUtils.rm_rf(File.join(dir, ".git"))
end

vim_org_scripts.each do |name, script_id, script_type|
#  next unless should_update name
  puts " Downloading #{name}"
  local_file = make_local_file_name(name, script_type)
  FileUtils.mkdir_p(File.dirname(local_file))
  File.open(local_file, "w") do |file|
    file << open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}").read
  end
  if script_type == 'zip'
    %x(unzip -d #{name} #{local_file})
  end
	if script_type == 'tar'
		%x(mv #{local_file} #{name};cd #{name};tar xzvf *.tar)
	end
end


other_scripts.each do |name, url, script_type|
#  next unless should_update name
  puts " Downloading #{name}"
  local_file = make_local_file_name(name, script_type)
  FileUtils.mkdir_p(File.dirname(local_file))
  File.open(local_file, "w") do |file|
    file << open(url).read
  end
  if script_type == 'zip'
    %x(unzip -d #{name} #{local_file})
  end
	if script_type == 'tar'
		%x(mv #{local_file} #{name};cd #{name};tar xzvf *.#{script_type})
	end
end

# YouCompleteMe specific
%x(cd ./bundle/YouCompleteMe && ./install.sh)
# scala syntax highlighting
%x(scala_dir=~/Projects/scala-dist/tool-support/src/vim
vim_bundle_dir=~/.vim/bundle/vim-scala
if [[ -d $scala_dir ]]; then
  if [[ ! -d $vim_bundle_dir ]]; then
    mkdir $vim_bundle_dir
  fi
   cp -R $scala_dir $vim_bundle_dir
   exit 0
 fi
 echo $scala_dir not found)
