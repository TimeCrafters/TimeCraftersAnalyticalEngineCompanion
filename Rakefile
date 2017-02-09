require "releasy"
require 'bundler/setup' # Releasy requires that your application uses bundler.

Releasy::Project.new do
  name "TimeCrafters Analytical Engine"
  version "Wildflower-beta_01"

  executable "timecrafters_analytical_engine.rb"
  files ["lib/**/*.*", "data/**/*.*"]
  exclude_encoding # Applications that don't use advanced encoding (e.g. Japanese characters) can save build size with this.
  verbose

  add_build :windows_folder do
    # icon "assets/icon.ico"
    executable_type :console # Assuming you don't want it to run with a console window.
    add_package :exe # Windows self-extracting archive.
  end
end
