// ref:
// - https://umijs.org/plugin/develop.html
import { IApi } from 'umi-plugin-types';
interface Options {
  name: string
}

export default function(api: IApi, options: Options) {
  const { name } = options
  api.modifyDefaultConfig((memo) => {
    return {
      ...memo,
      base: `/${name}`,
      outputPath: `./dist/${name}`,
      publicPath: `/${name}/`,
      mountElementId: `${name}`,
      define: {
        // @ts-ignore
        ...memo.define,
        API_PREFIX: `/api/${name}`
      },
    }
  })
}
