require 'test_helper'

describe Cask::CLI::Info do
  it 'displays some nice info about the specified cask' do
    lambda {
      Cask::CLI::Info.run('local-caffeine')
    }.must_output <<-CLIOUTPUT.undent
      local-caffeine: 1.2.3
      http://example.com/local-caffeine
      Not installed
      https://github.com/caskroom/homebrew-testcasks/blob/master/Casks/local-caffeine.rb
      ==> Contents
        Caffeine.app (link)
    CLIOUTPUT
  end

  describe 'given multiple casks' do
    before do
      @expected_output = <<-CLIOUTPUT.undent
        local-caffeine: 1.2.3
        http://example.com/local-caffeine
        Not installed
        https://github.com/caskroom/homebrew-testcasks/blob/master/Casks/local-caffeine.rb
        ==> Contents
          Caffeine.app (link)
        local-transmission: 2.61
        http://example.com/local-transmission
        Not installed
        https://github.com/caskroom/homebrew-testcasks/blob/master/Casks/local-transmission.rb
        ==> Contents
          Transmission.app (link)
      CLIOUTPUT
    end

    it 'displays the info' do
      lambda {
        Cask::CLI::Info.run('local-caffeine', 'local-transmission')
      }.must_output(@expected_output)
    end

    it 'throws away stray options' do
      lambda {
        Cask::CLI::Info.run('--notavalidoption', 'local-caffeine', 'local-transmission')
      }.must_output(@expected_output)
    end
  end

  it 'should print caveats if the cask provided one' do
    lambda {
      Cask::CLI::Info.run('with-caveats')
    }.must_output <<-CLIOUTPUT.undent
      with-caveats: 1.2.3
      http://example.com/local-caffeine
      Not installed
      https://github.com/caskroom/homebrew-testcasks/blob/master/Casks/with-caveats.rb
      ==> Contents
        Caffeine.app (link)
      ==> Caveats
      Here are some things you might want to know.

      Cask title: with-caveats

      Custom text via puts followed by DSL-generated text:
      To complete the installation of Cask with-caveats, you must also
      run the installer at

        '#{Cask.caskroom}/with-caveats/1.2.3/Installer.app'

    CLIOUTPUT
  end

  it 'should not print caveats title if caveats block has no output' do
    lambda {
      Cask::CLI::Info.run('with-conditional-caveats')
    }.must_output <<-CLIOUTPUT.undent
      with-conditional-caveats: 1.2.3
      http://example.com/local-caffeine
      Not installed
      https://github.com/caskroom/homebrew-testcasks/blob/master/Casks/with-conditional-caveats.rb
      ==> Contents
        Caffeine.app (link)
    CLIOUTPUT
  end

  describe "when no cask is specified" do
    it "raises an exception" do
      lambda {
        Cask::CLI::Info.run()
      }.must_raise CaskUnspecifiedError
    end
  end

  describe "when no cask is specified, but an invalid option" do
    it "raises an exception" do
      lambda {
        Cask::CLI::Info.run('--notavalidoption')
      }.must_raise CaskUnspecifiedError
    end
  end
end
