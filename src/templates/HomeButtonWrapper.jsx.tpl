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
      'url("http://172.16.17.29/front-end/uni/uploads/80bd97e7770822d5d78cc42f701e34d1/Home__1_.png") no-repeat 100% 100%',
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
  const { children, portalDomain } = props
  const [position, setPosition] = React.useState(getLocalPosition())
  const [dragging, setDrag] = React.useState(false)
  const onDrag = () => {
    setDrag(true)
  }
  const onStop = (e, data) => {
    e.stopPropagation()
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
    if (!dragging) {
      window.open('{{{portalDomain}}}', '_self')
    }
    setDrag(false)
  }
  return (
    <React.Fragment>
      <Draggable
        bounds="body"
        position={position}
        onDrag={onDrag}
        onStop={onStop}
      >
        <div title="回到主系统" style={styles.homeButtonWrapper}></div>
      </Draggable>
      {children}
    </React.Fragment>
  )
}

export default HomeButtonProvider
