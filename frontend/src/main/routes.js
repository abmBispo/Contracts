import React from 'react';
import { Route } from 'react-router-dom';
import Contracts from '../components/Contracts';
import Part from '../components/Part';
import FormPart from '../components/Part/Form';

export default () => (
  <>
    <Route exact path='/contracts' component={Contracts} />
    <Route exact path='/parties' component={Part} />
    <Route exact path='/parties/new' component={FormPart} />
    <Route exact path='/parties/:userId/update' component={FormPart} />
  </>
);
