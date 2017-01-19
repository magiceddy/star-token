import { compose, createStore, applyMiddleware } from 'redux';
import reducers from './reducers';

const composeEnhancers =
    process.env.NODE_ENV !== 'production' &&
    typeof window === 'object' &&
    window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ ?   
      window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__({
        // Specify here name, actionsBlacklist, actionsCreators and other options
      }) : compose;

export const getStore = () => {

    const initialState = {},
          middleware = [],
          enhancers = composeEnhancers(applyMiddleware(...middleware));

    return createStore(reducers, initialState, compose(...enhancers));
};