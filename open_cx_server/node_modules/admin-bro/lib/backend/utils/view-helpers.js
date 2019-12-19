"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;
let globalAny = {};

try {
  globalAny = window;
} catch (error) {
  if (error.message !== 'window is not defined') {
    throw error;
  }
}
/**
 * Params for a record action
 * @alias RecordActionParams
 * @memberof ViewHelpers
 */


/**
 * Collection of helper methods available in the views
 */
class ViewHelpers {
  constructor({
    options
  } = {}) {
    let opts = options || globalAny.REDUX_STATE && globalAny.REDUX_STATE.paths;
    opts = opts || {
      rootPath: '/admin'
    }; // when ViewHelpers are used on the frontend, paths are taken from global Redux State

    this.options = opts;
  }
  /**
   * To each related path adds rootPath passed by the user, as well as a query string
   * @private
   * @param  {Array<string>} paths   list of parts of the url
   * @return {string}       path
   */


  urlBuilder(paths) {
    const {
      rootPath
    } = this.options;
    return `${rootPath}/${paths.join('/')}`;
  }
  /**
   * Returns login URL
   * @return {string}
   */


  loginUrl() {
    return this.options.loginPath;
  }
  /**
   * Returns logout URL
   * @return {string}
   */


  logoutUrl() {
    return this.options.logoutPath;
  }

  listUrl({
    resourceId
  }) {
    console.warn(`
      Deprecation: this "ViewHelpers#listUrl" will be removed in the next versions.
      Please use "resourceActionUrl({ resourceId, actionName: 'list'})"
      instead`);
    return this.resourceActionUrl({
      resourceId,
      actionName: 'list'
    });
  }
  /**
   * Returns URL for the dashboard
   * @return {string}
   */


  dashboardUrl() {
    return this.options.rootPath;
  }
  /**
   * Returns resourceAction url
   *
   * @param   {ResourceActionParams}  options
   * @param   {string}  options.resourceId
   * @param   {string}  options.actionName
   *
   * @return  {string}
   */


  resourceActionUrl({
    resourceId,
    actionName
  }) {
    return this.urlBuilder(['resources', resourceId, 'actions', actionName]);
  }
  /**
   * Returns recordAction url
   *
   * @param   {RecordActionParams}  options
   * @param   {string}  options.resourceId
   * @param   {string}  options.recordId
   * @param   {string}  options.actionName
   *
   * @return  {string}
   */


  recordActionUrl({
    resourceId,
    recordId,
    actionName
  }) {
    return this.urlBuilder(['resources', resourceId, 'records', recordId, actionName]);
  }
  /**
   * Returns absolute path to a given asset.
   * @private
   *
   * @param  {string} asset
   * @return {string}
   */


  assetPath(asset) {
    return this.urlBuilder(['frontend', 'assets', asset]);
  }

}

var _default = ViewHelpers;
exports.default = _default;