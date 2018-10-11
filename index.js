import { NativeEventEmitter, NativeModules } from 'react-native';
const { RNNearbyManager as NearbyManager } = NativeModules;

const nearbyManagerEmitter = new NativeEventEmitter(NearbyManager);

export const init = uuid => {
  NearbyManager.init(/*'7b550bd4-ac73-4f54-aa36-2412f3680d43'*/uuid);
};

export const startAdvertisingWithUsername = username => {
  NearbyManager.startAdvertisingWithUsername(username);
};

export const stopAdvertising = () => {
  NearbyManager.stopAdvertising();
};

export const startDiscovering = () => {
  NearbyManager.startDiscovering();
};

export const stopDiscovering = () => {
  NearbyManager.stopDiscovering();
};

export const onUserChanged = cb => {
  nearbyManagerEmitter.addListener('userChanged', users => {
    console.log(users);
    if (cb) {
      cb(users);
    }
  });
};

export const ping = () => {
  NearbyManager.ping();
};

export const onPong = cb => {
  nearbyManagerEmitter.addListener('pong', strings => {
    if (cb) {
      cb(strings);
    }
  });
};
