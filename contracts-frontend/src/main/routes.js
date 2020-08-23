import React from 'react';
import { Router, Route, Redirect, hashHistory } from 'react-router';
import Contract from '../components/Contract';
import Part from '../components/Part';

export default () => (
  <Router history={hashHistory}>
    <Route path='/contracts' component={Contract} />
    <Route path='/parties' component={Part} />
    <Redirect from='*' to='/contracts' />
  </Router>
);
