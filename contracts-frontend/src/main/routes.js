import React from 'react';
import { Route } from 'react-router-dom';
import Contract from '../components/Contract';
import Part from '../components/Part';
import FormPart from '../components/Part/Form';

export default () => (
  <>
    <Route exact path='/contracts' component={Contract} />
    <Route exact path='/parties' component={Part} />
    <Route exact path='/parties/new' component={FormPart} />
    <Route exact path='/parties/:partId/update' component={FormPart} />
  </>
);
