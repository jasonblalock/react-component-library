module.exports = {
  extends: [
    'airbnb',
    'prettier',
    'prettier/react',
    'prettier/standard'
  ],
  plugins: ['prettier'],
  env: {
    browser: true,
    jest: true,
  },
  rules: {
    'react/jsx-filename-extension': ['error', { extensions: ['.js'] }],
    'react/jsx-sort-props': 'error',
    'prettier/prettier': ['error', { 'singleQuote': true }]
  }
};