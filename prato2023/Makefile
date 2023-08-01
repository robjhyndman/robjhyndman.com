### Build and deploy https://robjhyndman.com

all: serve

serve:
	quarto preview

build:
	quarto render

deploy:
	rsync -zrvce 'ssh -p 18765' ../_site/prato2023/ u190-dvt18hap6a80@ssh.robjhyndman.com:www/robjhyndman.com/public_html/prato2023

clean:
	rm -rf _site
	rm -rf _freeze
