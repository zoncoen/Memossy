Memossy
=============
This is simple web application for management some memos.  
This appication is powerd by sinatra-ish simple Perl WAF [Kossy](http://search.cpan.org/~kazeburo/Kossy-0.07/lib/Kossy.pm).

Installation requirements
-----
- MySQL
- Perl
- cpanm
- carton

How to setup
-----
```
# Get code
$ git clone https://github.com/zoncoen/Memossy.git

# Create MySQL database table and config file
$ cd Memossy
$ perl setup.pl

# Install Perl CAPN module
$ carton install
```

How to run
-----
```
# Run Memossy
$ carton exec -- plackup app.psgi --port=5000
```

Let's accesss [http://localhost:5000/](http://localhost:5000/) on your web browser.
