class AdobeReaderUnilung < Cask
  url 'http://ardownload.adobe.com/pub/adobe/reader/mac/11.x/11.0.06/misc/AdbeRdrUpd11006.dmg'
  homepage 'http://www.adobe.com/products/reader.html'
  version '11.0.06'
  sha256 'ae4f889b68729f2948cc80859012241b166d6efbf4113e63d5df4297531383f7'
  install 'AdbeRdrUpd11006.pkg'
  uninstall :pkgutil => 'com.adobe.acrobat.reader.11006.*'
end
