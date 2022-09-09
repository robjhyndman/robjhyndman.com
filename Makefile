### Build and deploy https://robjhyndman.com

all: serve

serve:
	quarto preview

build:
	quarto render

deploy: build
  cp .htaccess _site
	rsync -zrvce 'ssh -p 18765' _site/ u190-dvt18hap6a80@m80.siteground.biz:www/robjhyndman.com/public_html

clean:
	rm -rf _site
	rm -rf _freeze
