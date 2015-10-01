module ApplicationHelper
  def default_meta_tags
    {
      site: 'つけ麺ランキング',
      separator: '|',
      title: 'つけ麺ランキング - 「つけ麺」の味だけで評価するつけ麺検索サイト',
      description: '「つけ麺でお店を選びたい」そんなつけ麺ファンの期待に応えるのが「つけ麺ランキング」。全国のつけ麺を提供しているお店を、つけ麺の味だけでランキング！そのお店のラーメンがどんなに美味しくても関係ありません。',
      charset: 'utf-8',
    }
  end
end
