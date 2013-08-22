# -*- coding: utf-8 -*-
require 'spec_helper'

describe Calil::Library do
  describe 'find' do

    subject(:library) { Calil::Library.find(pref: "東京都").first }

    it 'first library systemid should "Tokyo_Akishima"' do
      library.systemid.should eql("Tokyo_Akishima")
    end

    it 'first library should hava inspect string' do
      library.inspect.should eql("#<Library systemid: 'Tokyo_Akishima', systemname: '東京都昭島市', libkey: 'BM', libid: '103852', short: 'もくせい号', formal: '昭島市動く図書館「もくせい号」', url_pc: 'http://www.library.akishima.tokyo.jp/index.html', address: '東京都昭島市東町2-6-33', pref: '東京都', city: '昭島市', post: '196-0033', tel: '042-543-1523', geocode: '139.3851232,35.7053229', category: 'BM', image: ''>")
    end

  end
end
