class Controllermate < Cask
  version :latest
  sha256 :no_check

  url 'https://s3.amazonaws.com/orderedbytes/ControllerMate.dmg'
  homepage 'http://www.orderedbytes.com/controllermate/'
  license :unknown

  pkg 'ControllerMate.pkg'
  uninstall :script => 'ControllerMate Uninstaller.app/Contents/MacOS/ControllerMate Uninstaller',
            :pkgutil => 'com.orderedbytes.controllermate.*'
end
