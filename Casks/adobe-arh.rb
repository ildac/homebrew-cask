class AdobeArh < Cask
  version :latest
  sha256 :no_check

  url 'http://airdownload.adobe.com/air/distribution/latest/mac/arh'
  homepage 'http://help.adobe.com/en_US/air/redist/WS485a42d56cd19641-70d979a8124ef20a34b-8000.html'
  license :unknown

  container :type => :naked
  binary 'arh'

  postflight do
    system '/bin/chmod', '--', '755', "#{destination_path}/arh"
  end

  caveats "Please refer to the documention at #{homepage}"
end
