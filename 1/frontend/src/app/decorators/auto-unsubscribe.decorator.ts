export function AutoUnsubscribe(options: { except: string[] } = { except: [] }) {
  return function (constructor) {
    const original = constructor.prototype.ngOnDestroy;

    constructor.prototype.ngOnDestroy = function () {
      for ( const prop of Object.keys(this) ) {
        const property = this[ prop ];
        if ( !options.except.includes(prop) ) {
          if ( property && typeof property.unsubscribe === 'function' ) {
            property.unsubscribe();
          }
        }
      }

      if (original && typeof original === 'function') {
        original.apply(this, arguments);
      }
    };
  };
}
