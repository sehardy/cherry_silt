# Cherry Silt -- MUD written in ruby using eventmachine
# Copyright (C) 2015 Sean Hardy

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'cherry_silt/version'

Gem::Specification.new do |s|
  s.name = 'cherry_silt'
  s.version = CherrySilt::VERSION
  s.platform = Gem::Platform::RUBY
  s.date = '2015-11-10'
  s.authors = IO.read(File.join(File.dirname(__FILE__), 'AUTHORS'))
  s.summary = 'MUD engine written in ruby with EventMachine'
  s.email = 'shardy107@gmail.com'
  s.description = s.summary
  s.homepage = 'https://github.com/sehardy/cherry_silt'

  s.license = 'GPL, v3.0'

  s.files = Dir['AUTHORS', 'LICENSE', 'README.md', 'Rakefile', 'bin/*', 'lib/**/*']
  s.require_paths = ['lib']
  s.bindir = 'bin'
  s.executables = %w( cherry-silt )

  %w(
    rake
    rspec
    rubocop
    cucumber
  ).each do |dev_gems|
    s.add_development_dependency dev_gems
  end

  %w(eventmachine mongo).each do |run_gems|
    s.add_runtime_dependency run_gems
  end
end
