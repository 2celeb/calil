# -*- coding: utf-8 -*-
require 'spec_helper'

describe Calil::Library do
  describe 'find' do
    subject(:library)  { @result = Calil::Library.find(pref: "東京都").first
      @result
    }
    it { library.systemid.should eql("Tokyo_Akishima") }
  end
end
