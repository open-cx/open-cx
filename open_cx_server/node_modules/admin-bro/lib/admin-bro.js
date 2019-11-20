"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = exports.bundle = exports.registerAdapter = exports.VERSION = void 0;

var _ = _interopRequireWildcard(require("lodash"));

var path = _interopRequireWildcard(require("path"));

var fs = _interopRequireWildcard(require("fs"));

var _configurationError = _interopRequireDefault(require("./backend/utils/configuration-error"));

var _resourcesFactory = _interopRequireDefault(require("./backend/utils/resources-factory"));

var _userComponentsBundler = _interopRequireDefault(require("./backend/bundler/user-components-bundler"));

var _constants = require("./constants");

var _loginTemplate = _interopRequireDefault(require("./frontend/login-template"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

const pkg = JSON.parse(fs.readFileSync(path.join(__dirname, '../package.json'), 'utf-8'));
const VERSION = pkg.version;
exports.VERSION = VERSION;
const defaults = {
  rootPath: _constants.DEFAULT_PATHS.rootPath,
  logoutPath: _constants.DEFAULT_PATHS.logoutPath,
  loginPath: _constants.DEFAULT_PATHS.loginPath,
  databases: [],
  resources: [],
  branding: {
    companyName: 'Company',
    softwareBrothers: true
  },
  dashboard: {},
  assets: {
    styles: [],
    scripts: [],
    globalsFromCDN: false
  }
};

/**
 * Main class for AdminBro extension. It takes {@link AdminBroOptions} as a
 * parameter and creates an admin instance.
 *
 * Its main responsibility is to fetch all the resources and/or databases given by a
 * user. Its instance is a currier - injected in all other classes.
 *
 * @example
 * const AdminBro = require('admin-bro')
 * const admin = new AdminBro(AdminBroOptions)
 */
class AdminBro {
  /**
   * Contains set of routes availables within the application.
   * It is used by external plugins.
   *
   * @example
   * const { Router } = require('admin-bro')
   * Router.routes.forEach(route => {
   *   // map your framework routes to admin-bro routes
   *   // see how `admin-bro-expressjs` plugin does it.
   * })
   */

  /**
   * abstract class for all databases. External adapters have to implement that.
   */

  /**
   * abstract class for all records. External adapters have to implement that or at least
   * their BaseResource implementation should return records of this type.
   */

  /**
   * abstract class for all resources. External adapters have to implement that.
   */

  /**
   * abstract class for all properties. External adapters have to implement that or at least
   * their BaseResource implementation should return records of this type.
   */

  /**
   * Filter object passed to find method of BaseResource. External adapters have to use it
   */

  /**
   * Validation error which is thrown when record fails validation. External adapters have
   * to use it.
   */

  /**
   * List of all default actions. If you want to change behaviour for all actions lika list,
   * edit, show and delete you can do this here.
   *
   * @example <caption>Modifying accessibility rules for all show actions</caption>
   * const { ACTIONS } = require('admin-bro')
   * ACTIONS.show.isAccessible = () => {...}
   */

  /**
   * AdminBro version
   */

  /**
   * List of all bundled components
   */

  /**
   * @param   {AdminBroOptions}  options  options passed to adminBro
   */
  constructor(options = {}) {
    /**
     * @type {BaseResource[]}
     * @description List of all resources available for the AdminBro.
     * They can be fetched with the {@link AdminBro#findResource} method
     */
    this.resources = [];
    /**
     * @type {AdminBroOptions}
     * @description Options given by a user
     */

    this.options = _.merge({}, defaults, options);
    const defaultLogo = `${this.options.rootPath}/frontend/assets/logo-mini.svg`;
    this.options.branding = this.options.branding || {};
    this.options.branding.logo = this.options.branding.logo || defaultLogo;
    const {
      databases,
      resources
    } = this.options;
    const resourcesFactory = new _resourcesFactory.default(this, AdminBro.registeredAdapters);
    this.resources = resourcesFactory.buildResources({
      databases,
      resources
    });
  }
  /**
   * Registers various database adapters written for AdminBro.
   *
   * @example
   * const AdminBro = require('admin-bro')
   * const MongooseAdapter = require('admin-bro-mongoose')
   * AdminBro.registerAdapter(MongooseAdapter)
   *
   * @param  {Object}       options
   * @param  {typeof BaseDatabase} options.Database subclass of BaseDatabase
   * @param  {typeof BaseResource} options.Resource subclass of BaseResource
   */


  static registerAdapter({
    Database,
    Resource
  }) {
    if (!Database || !Resource) {
      throw new Error('Adapter has to have both Database and Resource');
    } // checking if both Database and Resource have at least isAdapterFor method


    if (Database.isAdapterFor && Resource.isAdapterFor) {
      AdminBro.registeredAdapters.push({
        Database,
        Resource
      });
    } else {
      throw new Error('Adapter elements has to be subclassess of AdminBro.BaseResource and AdminBro.BaseDatabase');
    }
  }
  /**
   * Initializes AdminBro instance in production. This function should be called by
   * all external plugins.
   */


  async initialize() {
    if (process.env.NODE_ENV === 'production') {
      console.log('AdminBro: bundling user components...');
      await (0, _userComponentsBundler.default)(this, {
        write: true
      });
    }
  }
  /**
   * Renders an entire login page with email and password fields
   * using {@link Renderer}.
   *
   * Used by external plugins
   *
   * @param  {Object} options
   * @param  {String} options.action          login form action url - it could be
   *                                          '/admin/login'
   * @param  {String} [options.errorMessage]  optional error message. When set,
   *                                          renderer will print this message in
   *                                          the form
   * @return {Promise<string>}                HTML of the rendered page
   */


  static async renderLogin({
    action,
    errorMessage
  }) {
    return (0, _loginTemplate.default)({
      action,
      errorMessage
    });
  }
  /**
   * Returns resource base on its ID
   *
   * @example
   * const User = admin.findResource('users')
   * await User.findOne(userId)
   *
   * @param  {String} resourceId    ID of a resource defined under {@link BaseResource#id}
   * @return {BaseResource}         found resource
   * @throws {Error}                when resource with given id cannot be found
   */


  findResource(resourceId) {
    const resource = this.resources.find(m => m.id() === resourceId);

    if (!resource) {
      throw new Error([`There are no resources with given id: "${resourceId}"`, 'This is the list of all registered resources you can use:', this.resources.map(r => r.id()).join(', ')].join('\n'));
    }

    return resource;
  }
  /**
   * Requires given .jsx/.tsx file, that it can be bundled to the frontend.
   * It will be available under AdminBro.UserComponents[componentId].
   *
   * @param   {String}  src  path to a file containing react component.
   *
   * @return  {String}       componentId - uniq id of a component
   *
   * @example
   * const adminBroOptions = {
   *   dashboard: {
   *     component: AdminBro.bundle('./path/to/component'),
   *   }
   * }
   */


  static bundle(src) {
    const extensions = ['.jsx', '.js', '.ts', '.tsx'];
    let filePath = '';

    const componentId = _.uniqueId('Component');

    if (src[0] === '/') {
      filePath = src;
    } else {
      const stack = (new Error().stack || '').split('\n');
      const m = stack[2].match(/\((.*):[0-9]+:[0-9]+\)/);

      if (!m) {
        throw new Error('STACK does not have a file url. Chcek out if the node version >= 8');
      }

      filePath = path.join(path.dirname(m[1]), src);
    }

    const {
      root,
      dir,
      name
    } = path.parse(filePath);

    if (!extensions.find(ext => {
      const fileName = path.format({
        root,
        dir,
        name,
        ext
      });
      return fs.existsSync(fileName);
    })) {
      throw new _configurationError.default(`Given file "${src}", doesn't exist.`, 'AdminBro.html');
    }

    AdminBro.UserComponents[componentId] = path.format({
      root,
      dir,
      name
    });
    return componentId;
  }

}

AdminBro.UserComponents = {};
AdminBro.registeredAdapters = [];
AdminBro.VERSION = VERSION;
const {
  registerAdapter
} = AdminBro;
exports.registerAdapter = registerAdapter;
const {
  bundle
} = AdminBro;
exports.bundle = bundle;
var _default = AdminBro;
exports.default = _default;