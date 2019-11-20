"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _server = require("react-dom/server");

var _styledComponents = require("styled-components");

var _login = _interopRequireDefault(require("./components/login"));

var theme = _interopRequireWildcard(require("./styles/variables"));

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/* eslint-disable @typescript-eslint/explicit-function-return-type */
const onProd = process.env.NODE_ENV === 'production';

const html = ({
  action,
  errorMessage
}) => {
  const loginComponent = (0, _server.renderToString)( // eslint-disable-next-line react/jsx-filename-extension
  _react.default.createElement(_styledComponents.ThemeProvider, {
    theme: theme
  }, _react.default.createElement(_login.default, {
    action: action,
    message: errorMessage
  })));
  const sheet = new _styledComponents.ServerStyleSheet();
  sheet.collectStyles(_login.default);
  const style = sheet.getStyleTags();
  sheet.seal();
  return `
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <title>AdminPanel</title>
      ${style}
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.5.1/css/bulma.min.css" type="text/css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-mfizz/2.4.1/font-mfizz.min.css" type="text/css">
      <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700" type="text/css">

      <script src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
      <script crossorigin src="https://unpkg.com/react@16/umd/react.${onProd ? 'production.min' : 'development'}.js"></script>
      <script crossorigin src="https://unpkg.com/react-dom@16/umd/react-dom.${onProd ? 'production.min' : 'development'}.js"></script>
    </head>
    <body>
      <div id="app">${loginComponent}</div>
    </body>
    </html>
  `;
};

var _default = html;
exports.default = _default;