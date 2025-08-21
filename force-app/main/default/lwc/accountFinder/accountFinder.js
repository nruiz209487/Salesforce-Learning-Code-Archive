import { LightningElement, wire } from 'lwc';
import queryAccountsByRevenue from '@salesforce/apex/AccountListControllerLwc.queryAccountsByRevenue';

export default class AccountFinder extends LightningElement {
    annualRevenue = null;
    accounts;

    handleChange(event) {
        this.annualRevenue = event.detail.value;
    }

    reset() {
        this.annualRevenue = null;
    }

    @wire(queryAccountsByRevenue, { annualRevenue: '$annualRevenue' })
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            console.error(error);
        }
    }
}
