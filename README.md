# typescript-node-with-linting

Template repository for a TypeScript Node project with linting.

## How to Use

To use this repository, you might need to update a few things.

### `package.json`

In the `package.json` file, modify the following properties:

-   `name` - The name of your project.
-   `version` - The version of your project.
-   `description` - The description of your project.
-   `repository.url` - The URL to where your new repository is located.
-   `bugs.url` - The URL to where users can submit issues.
-   `homepage` - The website for your code.

### `tsconfig.json`

There are a few experimental features and opinionated things turned on here like `experimentalDecorators` and `emitDecoratorMetadata`. This can all be tweaked.

### `Dockerfile`

The container is setup for multi-stage builds. The `development` stage serves as the dev container. It will start `ts-node-dev` (similar to `nodemon` for those coming from JS).

The `builder` stage runs through the TypeScript transpiler. The `production` stage will export just the `dist` folder and install the production `node_modules`.

This will need to be modified depending on the type of application you're building. It doesn't consider any of the frontend assets that might need to be compiled.

### `docker-compose.yml`

The compose file is setup for conveniently starting the application. However, you can add more services here to serve your needs.

## Workflow Tips

The `node_modules` folder is mounted as a volume. When managing dependencies, it's best to run `npm install` inside of the container. You can either do this by attaching a shell:

```
[~/Repos/typescript-node-with-linting] $ docker-compose up app
[~/Repos/typescript-node-with-linting] $ docker-compose exec app sh
/app # npm install
```

Or by executing a one-time command

```
[~/Repos/typescript-node-with-linting] $ docker-compose up app
[~/Repos/typescript-node-with-linting] $ docker-compose exec npm install ...
```

There is one caveat with this. I have `Husky` setup along with `lint-staged` for running pre-commit hooks. This means you will more than likely want to run an `npm install` locally so that the pre-commit hooks can be registered.

Otherwise, you can create your own pre-commit hook (if you want). See [How to run ESLint using pre-commit hook](https://medium.com/@rashtay/how-to-run-eslint-using-pre-commit-hook-25984fbce17e).
