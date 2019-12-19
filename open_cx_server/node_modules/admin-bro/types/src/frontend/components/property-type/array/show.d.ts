import React, { ReactNode } from 'react';
import PropertyJSON from '../../../../backend/decorators/property-json.interface';
import RecordJSON from '../../../../backend/decorators/record-json.interface';
declare type Props = {
    property: PropertyJSON;
    record: RecordJSON;
    ItemComponent: typeof React.Component;
};
export default class Show extends React.PureComponent<Props> {
    render(): ReactNode;
}
export {};
