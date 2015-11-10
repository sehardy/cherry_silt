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

$:.push File.expand_path("../lib", __FILE__)
require "cherry_silt/version"

Gem::Specification.new do |s|
  s.name = 'cherry_silt'
  s.version = CherrySilt::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = IO.read(File.join(File.dirname(__FILE__), 'AUTHORS'))
  s.summary = 'MUD written in ruby'
  s.description = s.summary
  s.homepage = ''

  s.license = 'GPL, v3.0'

  s.files = `git ls-files`.split("\n")
  s.require_paths = ['lib']
  s.bindir = 'bin'
  s.executables = %w( cherry-silt )

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'cucumber'

  s.add_runtime_dependency 'eventmachine'
end
