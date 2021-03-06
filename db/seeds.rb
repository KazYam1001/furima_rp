require 'csv'

def seed(csv) ##csvファイルを投げると自動でseedを入れてくれるメソッド
  classname = File.basename(csv, ".*").slice(0..-6).classify ##パス名をクラス名に変換。
  records = [] ## BULK INSERTをするための配列
  CSV.foreach(csv, headers: true) do |row| ##csvファイルからレコードを取り出していく。
    records << Object.const_get(classname).new(row.to_hash) ## Object.const_get(classname)はクラス名を変数で指定する方法
  end
   ## ↓BULK INSERTでテーブルに登録（バリデーション無視、同レコードは重複させない）
  Object.const_get(classname).import records, on_duplicate_key_update: records[0].attributes.keys, validate: false
end

Dir.glob("db/*.csv").each do |csv| ## dbディレクトリの全csvファイルを取り込む
 seed(csv)
end

User.find_or_create_by!(email: 'seller@com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.nickname = 'seller'
  user.first_name = '出品'
  user.last_name = 'マン'
  user.first_name_reading = 'シュッピン'
  user.last_name_reading = 'マン'
  user.birthday = Date.new(2020,1,1)
end

User.find_or_create_by!(email: 'buyer@com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.nickname = 'buyer'
  user.first_name = '購入'
  user.last_name = 'マン'
  user.first_name_reading = 'コウニュウ'
  user.last_name_reading = 'マン'
  user.birthday = Date.new(2020,1,1)
end
