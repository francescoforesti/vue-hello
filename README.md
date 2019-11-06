##Project development
https://www.freecodecamp.org/news/how-to-create-a-vue-js-app-using-single-file-components-without-the-cli-7e73e5b8244f/

#### Project init
`mkdir vue-hello`

`cd vue-hello`

`npm init`

`touch src src/App.vue src/index.html src/main.js .babelrc.js webpack-config.js`

`npm install vue vue-loader vue-template-compiler webpack webpack-cli webpack-dev-server babel-loader @babel/core @babel/preset-env css-loader vue-style-loader html-webpack-plugin rimraf -D`

#### Dev commands
`npm run serve`

`npm run build`

##Containerization
https://mycodesmells.com/post/serving-static-files-with-nginx
e.g.
`docker build -t francescoforestiphoopsit/hello-vue:20191106000759 .`
`docker push francescoforestiphoopsit/hello-vue:20191106000759`