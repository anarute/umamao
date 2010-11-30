# Umamão (pt)

O [Umamão](http://umamao.com) é uma comunidade de acadêmicos e
profissionais trocando conteúdo de qualidade na forma de perguntas e
respostas.

O site, no momento (Novembro de 2010), está em um *beta* restrito às
comunidades USP e Unicamp, mas temos planos de estender o acesso a
outras universidades e idiomas em breve.

Para acompanhar notícias sobre o Umamão, siga-nos no
[Twitter](http://twitter.com/umamao), no
[Facebook](http://www.facebook.com/pages/Umamao/110957438924904), e no
[nosso blog](http://blog.umamao.com).

Você também pode nos contactar diretamente através do email
contato@umamao.com.

Se estiver interessado em contribuir no desenvolvimento do código, dê
uma olhada no tópico "[Umamão
(desenvolvimento)](http://umamao.com/topics/Umam%C3%A3o-desenvolvimento)". Se
tiver dúvidas, pode perguntar ali mesmo :)

# Umamão (en)

[Umamão](http://umamao.com) is a knowledge-sharing community of
academics and professionals focused on creating high-quality content
in the form of questions and answers.

The website is, as of November 2010, in a private beta in two
Brazilian universities (USP and Unicamp), but we have plans to roll it
out to more universities and languages soon.

To stay up-to-date on all things Umamão, you follow us on
[Twitter](http://twitter.com/umamao),
[Facebook](http://www.facebook.com/pages/Umamao/110957438924904), and
[our blog](http://blog.umamao.com). (Everything is in Portuguese for
now.)

You can also contact us in Portuguese or in English at
contato@umamao.com.

## Shapado

Umamão is a fork of [Shapado](http://shapado.com), a free software
project under the AGPL. We are forever indebted to its authors for
providing a base for us to build upon. As our focus is very different
from theirs, our codebases have drifted apart, and are now in practice
unmergeable (hence the repository rename), but we want to collaborate
further with them as we get more resources.

== Dependencies

- git >= 1.5
- ruby >= 1.8.6 <1.9
- rubygems >= 1.3.5
- mongodb >= 1.4
- ruby on rails =2.3.8

== Install Ruby On Rails

sudo gem install -v=2.3.8 rails

== Getting Started

1. Download the sources:

    git clone git://gitorious.org/shapado/shapado.git

    cd shapado/

2. Configure the application

    cp config/shapado.sample.yml config/shapado.yml

    edit shapado.yml

3. Install dependencies

    rake gems:install

4. Download GeoIP data

    script/update_geoip

5. Load default data

    rake bootstrap

6. Add default subdomain to /etc/hosts, for example:

    "0.0.0.0 localhost.lan group1.localhost.lan group2.localhost.lan"

7. Start the server

    script/server
