import { compose, createStore, applyMiddleware } from 'redux';
import reducers from './reducers';

export const getStore = () => {

    const initialState = {},
          middleware = [],
          enhancers = [
              applyMiddleware(...middleware),
              window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
              ];

    return createStore(reducers, initialState, compose(...enhancers));
};