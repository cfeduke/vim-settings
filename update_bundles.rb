#!/usr/bin/env ruby

git_bundles = [ 
  "git://github.com/msanders/snipmate.vim.git",
	#use wycats modified janus nerdtree
	"git://github.com/wycats/nerdtree.git",  
  "git://github.com/tpope/vim-fugitive.git",
  "git://github.com/tpope/vim-rails.git",
  "git://github.com/tpope/vim-repeat.git",
  "git://github.com/tpope/vim-surround.git",
  "git://github.com/vim-ruby/vim-ruby.git",
	"git://github.com/altercation/vim-colors-solarized.git",
	"git://github.com/cfeduke/snipmate.vim.git",
  "git://github.com/jeffkreeftmeijer/vim-numbertoggle.git",
  "git://github.com/scrooloose/nerdcommenter.git",
  "git://github.com/mileszs/ack.vim.git",
  "git://github.com/vim-scripts/YankRing.vim.git",
  "git://github.com/claco/jasmine.vim.git",
	"git://github.com/docunext/closetag.vim.git",
  "git://github.com/wincent/Command-T.git",
  "git://github.com/sjl/gundo.vim.git",
  "git://github.com/godlygeek/tabular.git",
  "git://github.com/Lokaltog/vim-easymotion.git",
  "git://github.com/vim-scripts/vim-creole.git",
  "git://github.com/sebastiangeiger/sweet-rspec-vim.git",
]

vim_org_scripts = [
  ["gist",          "15452", "plugin"],
  ["jquery",        "12276", "syntax"],
  ["fuzzyfinder",   "13961",   "zip"],
  ["l9",  					"13948",   "zip"],
]

other_scripts = [
]


require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.cd(bundles_dir)

puts "Trashing everything (lookout!)"
Dir["*"].each {|d| FileUtils.rm_rf d }

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '')
  puts "  Unpacking #{url} into #{dir}"
  `git clone #{url} #{dir}`
  FileUtils.rm_rf(File.join(dir, ".git"))
end

vim_org_scripts.each do |name, script_id, script_type|
#  next unless should_update name
  puts " Downloading #{name}"
  local_file = File.join(name, script_type, "#{name}.#{script_type == 'zip' ? 'zip' : script_type == 'tar' ? 'tar': 'vim'}")
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
  local_file = File.join(name, script_type, "#{name}.#{script_type == 'zip' ? 'zip' : 'vim'}")
  FileUtils.mkdir_p(File.dirname(local_file))
  File.open(local_file, "w") do |file|
    file << open(url).read
  end
  if script_type == 'zip'
    %x(unzip -d #{name} #{local_file})
  end
end
