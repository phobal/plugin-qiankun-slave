// ref:
// - https://umijs.org/plugin/develop.html

interface Options {
  name: string
}

export default function(api, options: Options) {
  const { name } = options
  api.modifyDefaultConfig((memo) => {
    return {
      ...memo,
      base: `/${name}`,
      outputPath: `./dist/${name}`,
      publicPath: `/${name}/`,
      mountElementId: `${name}`,
      define: {
        ...memo.define,
        API_PREFIX: `/api/${name}`
      },
    }
  })
  api.changePluginOption('umi-plugin-react:dll', {
    dll: false,
  })
}
