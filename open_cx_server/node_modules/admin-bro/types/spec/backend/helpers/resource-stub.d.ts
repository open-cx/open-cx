import BaseProperty from '../../../src/backend/adapters/base-property';
import BaseResource from '../../../src/backend/adapters/base-resource';
export declare const expectedResult: {
    id: string;
    properties: BaseProperty[];
    resourceName: string;
    databaseName: string;
    databaseType: string;
    parent: {
        name: string;
        icon: string;
    };
};
declare const _default: () => BaseResource;
export default _default;
