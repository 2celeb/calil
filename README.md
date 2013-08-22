# Calil

図書館検索のカーリルのapiのruby用のラッパーです

#### できること

* 図書館の所在検索
* 指定した書籍の存在確認
* 指定した書籍の予約urlの取得

#### 詳しくはカーリル様のサイトで確認してください。
http://calil.jp/


## Installation

Add this line to your application's Gemfile:

    gem 'calil'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install calil

## Usage

### 図書館を検索する
```ruby
Calil::Library.find(pref: "東京都").first
```

```
# 図書館の情報を検索できる
=> #<Library systemid: 'Tokyo_Akishima', systemname: '東京都昭島市', libkey: 'BM', libid: '103852', short: 'もくせい号', formal: '昭島市動く図書館「もくせい号」', url_pc: 'http://www.library.akishima.tokyo.jp/index.html', address: '東京都昭島市東町2-6-33', pref: '東京都', city: '昭島市', post: '196-0033', tel: '042-543-1523', geocode: '139.3851232,35.7053229', category: 'BM', image: ''>
```

### 蔵書情報を検索する

```ruby
Calil::Book.find(["4844330845", "4798125415"], %w(Tokyo_Minato Tokyo_Chiyoda))
```

```
# 書籍の貸出状況が取得できる
=> [#<Book isbn: '4844330845', calilurl: 'http://calil.jp/book/4844330845', reservable?: 'true' systems: [#<System systemid: 'Tokyo_Chiyoda', status: 'Cache', reserveurl: 'http://www.library.chiyoda.tokyo.jp/wo/opc_srh/srh_detail?detail[sid]=151345917', reservable?: 'true'>, #<System systemid: 'Tokyo_Minato', status: 'Cache', reserveurl: '', reservable?: 'false'>]>, #<Book isbn: '4798125415', calilurl: 'http://calil.jp/book/4798125415', reservable?: 'false' systems: [#<System systemid: 'Tokyo_Chiyoda', status: 'Cache', reserveurl: '', reservable?: 'false'>, #<System systemid: 'Tokyo_Minato', status: 'Cache', reserveurl: '', reservable?: 'false'>]>]
```

```ruby
book = Calil::Book.find(["4844330845", "4798125415"], %w(Tokyo_Minato Tokyo_Chiyoda)).first
book.reservable?
```

```
# 借りられる
=> true
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
