"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _server = require("react-dom/server");

var _reactRouterDom = require("react-router-dom");

var _reactRedux = require("react-redux");

var _styledComponents = require("styled-components");

var _application = _interopRequireDefault(require("./components/app/application"));

var _viewHelpers = _interopRequireDefault(require("../backend/utils/view-helpers"));

var _store = _interopRequireDefault(require("./store"));

var _combineStyles = _interopRequireDefault(require("./styles/combine-styles"));

var _globalDependencies = _interopRequireDefault(require("./utils/global-dependencies"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const html = (admin, currentAdmin, location = '/') => {
  const context = {};
  const h = new _viewHelpers.default({
    options: admin.options
  });
  const locationInAdmin = h.urlBuilder([location]);
  const store = (0, _store.default)(admin, currentAdmin);
  const reduxState = store.getState();
  const scripts = (admin.options.assets && admin.options.assets.scripts || []).map(s => `<script src="${s}"></script>`);
  const styles = (admin.options.assets && admin.options.assets.styles || []).map(l => `<link rel="stylesheet" type="text/css" href="${l}">`);
  const theme = (0, _combineStyles.default)(admin.options.branding && admin.options.branding.theme || {});

  const jsx = // eslint-disable-next-line react/jsx-filename-extension
  _react.default.createElement(_reactRedux.Provider, {
    store: store
  }, _react.default.createElement(_styledComponents.ThemeProvider, {
    theme: theme
  }, _react.default.createElement(_reactRouterDom.StaticRouter, {
    context: context,
    location: locationInAdmin
  }, _react.default.createElement(_application.default, null))));

  const appComponent = (0, _server.renderToString)(jsx);
  return `
    <!DOCTYPE html>
    <html>
    <head>
      <script>
        window.REDUX_STATE = ${JSON.stringify(reduxState)};
        window.THEME = ${JSON.stringify(theme)};
        window.AdminBro = { Components: {} };
      </script>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <title>${admin.options.branding.companyName}</title>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.5.7/flatpickr.min.js"></script>
      <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.5.7/flatpickr.min.css">

      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.5.1/css/bulma.min.css" type="text/css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-mfizz/2.4.1/font-mfizz.min.css" type="text/css">
      <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700" type="text/css">
      <link rel="stylesheet" type="text/css" href="${h.assetPath('icomoon.css')}">

      <link rel="stylesheet" type="text/css" href="https://cdn.quilljs.com/1.3.6/quill.snow.css">
      <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
      <script src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
      ${(0, _globalDependencies.default)({
    fromCDN: admin.options.assets.globalsFromCDN,
    viewHelpers: h
  })}
      <script src="${h.assetPath('app.bundle.js')}"></script>
      <script src="${h.assetPath('components.bundle.js')}"></script>
      ${styles.join('\n')}
    </head>
    <body>
      <div id="app">${appComponent}</div>
      <script>
        var app = document.getElementById( 'app' );
        ReactDOM.hydrate( AdminBro.Application, app );
      </script>
      ${scripts.join('\n')}
    </body>
    </html>
  `;
};

var _default = html;
exports.default = _default;