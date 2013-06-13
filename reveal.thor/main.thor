class Reveal < Thor
  include Thor::Actions
  package_name 'Reveal'

  def self.source_root
    File.dirname(__FILE__)
  end

  desc 'init NAME', 'Init a new Reveal.js presentation'
  def init(name)
    @name = name
    directory('templates', "#{dir}")
    git_init
    git_submodule
    git_commit
  end


  private

  def dir
    @name.downcase.gsub(' ', '-') + '-presentation'
  end

  def name
    @name.capitalize
  end

  def git_init
    `git init #{dir}`
  end

  def git_submodule
    `cd #{dir}; git submodule add git://github.com/hakimel/reveal.js.git`
  end

  def git_commit
    `cd #{dir}; git add .; git commit -m Initial`
  end
end
