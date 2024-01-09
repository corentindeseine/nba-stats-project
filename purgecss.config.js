module.exports = {
  content: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
  ],
  css: ['./app/assets/stylesheets/**/*.css'],
  defaultExtractor: (content) => content.match(/[\w-/:]+(?<!:)/g) || [],
};
