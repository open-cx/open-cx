/**
 * Type representing the AdminBro.Router
 * @memberof AdminBro
 * @alias RouterType
 */
export declare type RouterType = {
    assets: Array<{
        path: string;
        src: string;
    }>;
    routes: Array<{
        method: string;
        path: string;
        Controller: any;
        action: string;
        contentType?: string;
    }>;
};
/**
 * Contains list of all routes grouped to `assets` and `routes`.
 *
 * ```
 * {
 *   assets: [{
 *     path: '/frontend/assets/app.min.js',
 *     src: path.join(ASSETS_ROOT, 'scripts/app.min.js'),
 *   }, ...],
 *   routes: [{
 *     method: 'GET',
 *     path: '/resources/{resourceId}',
 *     Controller: ResourcesController,
 *     action: 'index',
 *   }, ...]
 * }
 *
 * ```
 *
 * It is used by supported frameworks to render AdminBro pages.
 *
 * @private
 */
declare const Router: RouterType;
export default Router;
