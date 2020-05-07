import React from 'react'
import Draggable from 'react-draggable'

const styles = {
  homeButtonWrapper: {
    position: 'fixed',
    bottom: 20,
    right: 40,
    height: 48,
    width: 48,
    background:
      'url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAE8ElEQVRoQ9WaW2wbRRSG/7MhlbJr9RmUFF4qIUFKvG5AhDeKIEAJ4qJWAQRIUKUS0JIWCuyYSyrqXaBQQgtIjQAJEBBScVFDgXIpbw2CdNelAVTBC7QRPAfvRmrwHrTe2HEcJ96LkeV9GUue+c/5ZmbnnJlZQj2eySFZbp27hlzuAdAOQjvc+dLTZ0xDwnShBKZZoglnrvVbdA85cc1TVAF5UqSoBb0ArgbzBhC1+Fp8lkBnXL886/vPHRKog8FrAOrwq3EeRMcAfMd5HHW6dTOKL6EB5ElxAbXwIECDAFYB+JOBIwCOOKrulTUf2RIbAWwkwCsvBHAO4GHO07DTrf9VU6CsQigAxUoPAp7zuAiEcYY04iT3fBbGYGVdOfvkTQR3AIw+AH8ANGyrmeGgmoEAlB92nY/zWkdA6KuX4yuCMMbx79yAfcXev2uB1ARQpp7qwrn8OACZQFtzqcxHtUTj/J8w07cz+CAAB6ta+uzOZ0+upLciQOKk6GcXH4DoFLlufy5l/BLHuaBtE6Z2CUvSKJjXkYQ7cl366HJtlwVIZMU2Zuxn8CFHNTYHNV7PerKljRFoExG255L6gWraVQFkU9xAhM+Z+VUnZWyrp1NhtWRTO0BEDzHjRielf1HZfgnA6qkn1ubnpO8BmLaqXxfW4P9RX7HEVwBSLa3ulTOdz/1ebmMJgGJqXwN0sStRz2wy40XOhj9t2XS75PIEwKftlHHtsgDz6/zLrku3za7PfNJwz8scaDuRvlWS+GOAdpTHidII+BEWEyD8ZCf1m+vhfMLUdns6uZTxTD30lKw4DMZlnEdPMWKXABRLex6gx5ikvrjR1XM2YWkZBgnvN4H1nGqk40IUoja74wC/YKvG4762F6H8xMzr/aP16P1iZxCosPwyeKzcaByQ+VHonR8FswCgWNqjAO2tR+8rpvYSiHZ6zufUzCF/NNKbChDM++yU8UgcgLJR2GWrxosFgIQlPmXw5bZqtMcRV7LaK2DaXu58Ua8EQbzfThoPx7JjadME+jGn6rcQju9oU9raZkAYtZP63VGFZUu8RsAD1ZyvhGDgdUfVH4xqS8mKd8Hot2dnV5OSFb1gfLmS4VqGEpY4yMBAEI3iSBAwklP1rbW0q/2/MJq4nhRL6AA0W9VrZqbVxJSseBOM+4I4v3Q64S07qd8fBUKxBAMwPIC3Ad5gq8aasEJ+W9wTxvklEMA7tqrfG962dgagY94U+oYYck7VrwojoljiPQB3RnG+CsT7tqrfFcZ+whLHmeCQYopfmfhUmJRZscSHADbHcb4KxJgkSU//07XndBCQQqrNtM6bQjMA3rBVfWeghqb4jQhr6+H8Ugj62VYznUH8UCyxD8CW0ACKlZ4C+NKiEXax21mvDwUxWllHPiGGSEIpTyJgIuhUXgCIMIU8w54znvF6AHganl6YjliYQhFfYj8FEVwPgChL+MJLHG8ZbRiAYhWX0RiBrJEjsBDIYqQSjQJYlErESeYaBbAomYuTTjcMYFE6HWND0wiAqhuaqFvKRgBU3VL6a3r4TX0RIEoULrbxgmHQOLDspt4Ti3KsUpkKRAEJEwhXPFbxR6FwgdGcB1vF3mvqo0UPoukPdwvvQzMfr5c2Gc18wVGCaOYrptJL3cyXfCWIZr5mLQ9OTXvRXQ7R1J8aVIA058ceVfOdBn5u8x+Jzpe2CbqKAAAAAABJRU5ErkJggg==") no-repeat 100% 100%',
    cursor: 'pointer',
    zIndex: 1000,
  }
}
const getLocalPosition = () => {
  const position = localStorage.getItem('homeButtonPosition')
  const positionJSON = (position && JSON.parse(position)) || {}
  return {
    x: positionJSON.x || 0,
    y: positionJSON.y || 0
  }
}
const setLocalPosition = (data) => {
  localStorage.setItem('homeButtonPosition', JSON.stringify(data))
}

const HomeButtonProvider = (props) => {
  const { children, portalDomain, isShowButton } = props
  const [position, setPosition] = React.useState(getLocalPosition())
  const onStop = (e, data) => {
    e.stopPropagation()
    const { x: lastX, y: lastY } = getLocalPosition()
    setPosition({
      x: data.x,
      y: data.y
    })
    setLocalPosition({
      x: data.x,
      y: data.y
    })
    // 为了模拟触发 onClick 事件
    // https://github.com/mzabriskie/react-draggable/issues/49
    if (lastX === data.x && lastY === data.y) {
      window.open('{{{portalDomain}}}', '_self')
    }
  }
  return (
    <React.Fragment>
      {{#isShowButton}}
      <Draggable
        bounds="body"
        position={position}
        onStop={onStop}
      >
        <div title="回到主系统" style={styles.homeButtonWrapper}></div>
      </Draggable>
      {{/isShowButton}}
      {children}
    </React.Fragment>
  )
}

export default HomeButtonProvider
