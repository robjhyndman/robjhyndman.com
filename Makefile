### Build and deploy https://robjhyndman.com

default: preview

preview:
	quarto preview

build:
	quarto render
	quarto render unbelievable
	quarto render prato2023

deploy:
	chmod -R +r .
	Rscript make_xml.R
	cp .htaccess _site
	cp img/favicon.ico _site
	rsync -rau data/ _site/data/
	rsync -rau files/ _site/files/
	rsync -rau fonts/ _site/fonts/
	rsync -rau genealogy/ _site/genealogy/
	rsync -rau img/ _site/img/
	rsync -rau papers/ _site/papers/
	rsync -rau Rfiles/ _site/Rfiles/
	rsync -rau uwa2017/ _site/uwa2017/
	rsync -zrvce 'ssh -p 18765' _site/ u190-dvt18hap6a80@ssh.robjhyndman.com:www/robjhyndman.com/public_html

clean:
	rm -rf _site
