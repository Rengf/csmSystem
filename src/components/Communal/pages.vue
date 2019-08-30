<template>
  <div class="pages">
    <nav>
      <ul class="pagination">
        <li :class="{'disabled': current == 1}">
          <span @click="setCurrent(1)">首页</span>
        </li>
        <li :class="{'disabled': current == 1}">
          <span @click="setCurrent(current - 1)">上一页</span>
        </li>
        <li v-for="(p,index) in grouplist" :class="{'active': current == p.val}" :key="index">
          <span @click="setCurrent(p.val)">{{ p.text }}</span>
        </li>
        <li :class="{'disabled': current == page}">
          <span @click="setCurrent(current + 1)">下一页</span>
        </li>
        <li :class="{'disabled': current == page}">
          <span @click="setCurrent(page)">尾页</span>
        </li>
      </ul>
      <ul class="pagination pull-right">
        <li>
          <p>共 {{ total }} 条数据</p>
        </li>
        <li>
          <p>每页显示 {{ display }} 条数据</p>
        </li>
        <li>
          <p>共 {{ page }} 页</p>
        </li>
        <li>
          <p>当前第 {{ current }} 页</p>
        </li>
      </ul>
    </nav>
  </div>
</template>
<script>
export default {
  props: {
    total: {
      // 数据总条数
      type: Number,
      default: 89
    },
    display: {
      // 每页显示条数
      type: Number,
      default: 5
    },
    pagegroup: {
      // 分页条数 -- 奇数
      type: Number,
      default: 5,
      coerce(v) {
        v = v > 0 ? v : 5;
        return v % 2 === 1 ? v : v + 1;
      }
    }
  },
  data() {
    return {
      current: 0
    };
  },
  computed: {
    page() {
      // 总页数
      return Math.ceil(this.total / this.display);
    },
    grouplist() {
      // 获取分页页码
      var len = this.page,
        temp = [],
        list = [],
        count = Math.floor(this.pagegroup / 2),
        center = this.current;
      if (len <= this.pagegroup) {
        while (len--) {
          temp.push({ text: this.page - len, val: this.page - len });
        }
        return temp;
      }
      while (len--) {
        temp.push(this.page - len);
      }
      var index = temp.indexOf(center);
      index < count && (center = center + count - index);
      this.current > this.page - count && (center = this.page - count);
      temp = temp.splice(center - count - 1, this.pagegroup);
      do {
        var t = temp.shift();
        list.push({
          text: t,
          val: t
        });
      } while (temp.length);
      if (this.page > this.pagegroup) {
        this.current > count + 1 &&
          list.unshift({ text: "...", val: list[0].val - 1 });
        this.current < this.page - count &&
          list.push({ text: "...", val: list[list.length - 1].val + 1 });
      }
      return list;
    }
  },
  methods: {
    setCurrent(index) {
      if (this.current != index && index > 0 && index < this.page + 1) {
        this.current = index;
        this.$emit("pagechange", this.current - 1, this.display);
      }
    }
  }
};
</script>
<style scoped>
.active span {
  background: #2cabff;
  color: #fff;
}
.pages {
  margin-top: 20px;
  overflow: hidden;
}
.pagination {
  display: inline-block;
  vertical-align: top;
}
.pagination li {
  color: #0f71f0;
  display: inline-block;
  margin: 0 5px;
}
.pagination li span {
  display: block;
  padding: 10px 15px;
  cursor: pointer;
  border: 1px solid #ccc;
  border-radius: 5px;
}
.pull-right p {
  padding: 10px;
  color: #333;
}
</style>
