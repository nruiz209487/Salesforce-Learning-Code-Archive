// force-app/main/default/lwc/ldsUtils/reduceErrors.js
export function reduceErrors(errors) {
    if (!errors) return [];
    if (!Array.isArray(errors)) errors = [errors];
    return (
        errors
            .map(error => {
                if (Array.isArray(error.body)) {
                    return error.body.map(e => e.message);
                } else if (error.body && error.body.message) {
                    return error.body.message;
                } else if (error.message) {
                    return error.message;
                }
                return String(error);
            })
            .reduce((prev, curr) => prev.concat(curr), [])
            .filter(Boolean)
    );
}
