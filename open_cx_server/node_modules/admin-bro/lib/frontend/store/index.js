"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _store = _interopRequireWildcard(require("./store"));

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

const initializeStore = (admin, currentAdmin) => {
  const store = (0, _store.default)();
  const AdminClass = admin.constructor;
  const adminVersion = AdminClass.VERSION;
  store.dispatch((0, _store.initializeResources)(admin.resources.map(r => {
    try {
      return r.decorate().toJSON(currentAdmin);
    } catch (e) {
      console.log('error', r._decorated);
      throw e;
    }
  })));
  store.dispatch((0, _store.initializeBranding)(admin.options.branding));
  const {
    loginPath,
    logoutPath,
    rootPath,
    dashboard
  } = admin.options;
  store.dispatch((0, _store.initializePaths)({
    loginPath,
    logoutPath,
    rootPath
  }));
  store.dispatch((0, _store.initializeSession)(currentAdmin));
  store.dispatch((0, _store.initializeDashboard)(dashboard));
  store.dispatch((0, _store.initializeVersions)({
    app: admin.options.version && admin.options.version.app,
    admin: admin.options.version && admin.options.version.admin ? adminVersion : undefined
  }));
  return store;
};

var _default = initializeStore;
exports.default = _default;