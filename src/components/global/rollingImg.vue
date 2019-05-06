<template>
    <div class="rollingImg">
        <div class="viewPort" id="viewPort" @mouseover="stop" @mouseout="play">
            <transition-group tag="ul" name="image" class="boxSlider">
                <li v-for="(img, index) in imgList" v-show="index===mark" :key="img">
                    <img :src='img'>
                </li>
            </transition-group>
        </div>
        <div class="control">
            <a href="javascript:;" id="prev" class="prev" @click="prev" @mouseover="stop" @mouseout="play"></a>
            <a href="javascript:;" id="next" class="next" @click="next" @mouseover="stop" @mouseout="play"></a>
        </div>
    </div>
</template>
<script>
export default {
  name: "RollingImg",
  data() {
    return {
      mark: 0,
      imgList: [
        require("../../assets/images/1.jpg"),
        require("../../assets/images/2.jpg"),
        require("../../assets/images/3.jpg"),
        require("../../assets/images/4.jpg")
      ],
      timer: null
    };
  },
  created() {
    this.play();
  },
  methods: {
    next() {
      this.mark++;
      if (this.mark === 4) {
        //当遍历到最后一张图片置零
        this.mark = 0;
      }
    },
    play() {
      this.timer = setInterval(this.next, 5000);
    },
    stop() {
      clearInterval(this.timer);
    },
    change(i) {
      this.mark = i;
    },
    prev() {
      this.mark--;
      if (this.mark === -1) {
        //当遍历到最后一张图片置零
        this.mark = 3;
      }
    }
  }
};
</script>
<style scoped>
.image-enter-active,.image-leave-active {
  transition: opacity 2s;
}

.image-enter,.image-leave {
   opacity: 0;
}

.rollingImg {
  width: 100%;
  height: 500px;
  position: relative;
  top: -500px;
}

.viewPort {
  width: 100%;
  height: 500px;
  overflow: hidden;
}

.boxSlider {
  position: relative;
  width: 100%;
  height: 500px;
}

.boxSlider li {
  position: absolute;
}

.next {
  position: absolute;
  width: 71px;
  height: 71px;
  border-radius: 50%;
  top: 40%;
  right: 10%;
  background: url(../../assets/images/next.png) no-repeat rgba(0, 0, 0, 0.4);
}

.prev {
  position: absolute;
  width: 71px;
  height: 71px;
  border-radius: 50%;
  top: 40%;
  left: 10%;
  background: url(../../assets/images/prev.png) no-repeat rgba(0, 0, 0, 0.4);
}

.next:hover,
.prev:hover {
  background-color: rgba(0, 0, 0, 0.6);
  cursor: pointer;
}
</style>

