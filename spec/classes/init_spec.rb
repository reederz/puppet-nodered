require 'spec_helper'
describe 'nodered' do

  context 'with defaults for all parameters' do
    it { should contain_class('nodered') }
  end
end
