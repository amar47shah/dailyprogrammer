require 'yaml'

module RandomChallenge
  extend self
  LANGUAGES = ['clojure', 'coffeescript', 'cpp', 'csharp', 'ecmascript', 'elisp', 'elixir', 'elm',
             'erlang', 'fsharp', 'go', 'haskell', 'java', 'javascript', 'lfe', 'lisp', 'lua', 'objective-c',
             'ocaml', 'perl5', 'php', 'plsql', 'python', 'racket', 'ruby', 'rust', 'scala', 'scheme',
             'swift']
             # These languages are upcoming languages for exercism.
             # to enable them simple uncomment the below two lines and format array accordingly.
             #, 'groovy', 'perl6', 'vbnet', 'c', 'crystal', 'nim', 'pony', 'sml', 'bash', 'haxe', 'r',
             #'coldfusion'] 
  def generate_challenge
    rand = Random.new(Random.new_seed)
    begin
      past_results = YAML.load_file('past_results.yaml')
    rescue
      past_results = [nil, nil, nil, nil, nil, nil, nil]
    end
    rand_lang = rand(LANGUAGES.length - 1)
    while past_results.include?(rand_lang)
      rand_lang = rand(LANGUAGES.length - 1)
    end
    past_results[Time.now.day % 7 - 1] = rand_lang
    File.open('past_results.yaml', 'w') { |file| file.puts past_results.to_yaml }
    begin
      problems_raw = `exercism li #{LANGUAGES[rand_lang]}`
    rescue
      puts "Call to exercism failed. Do you have it installed? Are you connected to the internet?"
      exit
    end
    problems = problems_raw.split("\n").find_all { |problem| problem =~ /^[\w-]+$/ && problem != "hello-world" }
    rand_problem = rand(problems.length - 1)
    return LANGUAGES[rand_lang], problems[rand_problem]
  end
end

