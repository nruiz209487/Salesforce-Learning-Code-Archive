// force-app/main/default/lwc/ldsUtils/ldsUtils.js
export function reduceErrors(errors) {
    if (!errors) return [];
    if (!Array.isArray(errors)) errors = [errors];

    return errors
        .map(error => {
            if (Array.isArray(error.body)) {
                return error.body.map(e => e.message);
            } else if (error.body && error.body.message) {
                return error.body.message;
            } else if (error.message) {
                return error.message;
            }
            return error.statusText || 'Unknown error';
        })
        .flat();
}
