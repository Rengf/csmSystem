module.exports = {
    //添加商品分类
    addcategory(client, data, callback) {
        var sql = `insert into goods_type
        (goods_type_name,addgoodstype_time)
        values(?,?);`
        var params = [
            data.goods_type_name,
            data.addgoodstype_time
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //获取商品分类
    getcategorylist(client, callback) {
        var sql = `select * from goods_type`;
        client.query(sql, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //删除商品分类
    deletecategory(client, data, callback) {
        var sql = `delete from goods_type
        where goods_type_id=?`
        var params = [
            data.goods_type_id
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result)
        })
    },

    //添加商品
    addgoods(client, data, callback) {
        var sql = `insert into goods
        (goods_name,goods_picture,goods_price,goods_type_id,goods_description,addgoods_time,stock)
        values(?,?,?,?,?,?,?);`
        var params = [
            data.goods_name,
            data.goods_picture,
            data.goods_price,
            data.goods_type_id,
            data.goods_description,
            data.addgoods_time,
            data.stock
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //获取商品列表
    getgoodslist(client, callback) {
        var sql = `select * from goods as s
        inner join goods_type as t on t.goods_type_id=s.goods_type_id`;
        client.query(sql, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //获取商品
    getgoodsbyid(client, data, callback) {
        var sql = `select * from goods
        inner join goods_type on goods.goods_type_id=goods_type.goods_type_id
        where goods_id=?`;
        var params = [
            data.goods_id
        ]
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //更新商品库存
    updategoodsstock(client, data, callback) {
        var sql = `update goods set 
        stock=?
        where goods_id = ?`;
        var params = [
            data.stock,
            data.goods_id
        ]
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //删除商品
    deletegoods(client, data, callback) {
        var sql = `delete from goods
        where goods_id=?`
        var params = [
            data.goods_id
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result)
        })
    },

    //添加供应商
    addsupplier(client, data, callback) {
        var sql = `insert into supplier
        (supplier_name,supplier_contact,supplier_address,supplier_postcode,supplier_tel,supplier_email,supplier_bank,supplier_account)
        values(?,?,?,?,?,?,?,?);`
        var params = [
            data.supplier_name,
            data.supplier_contact,
            data.supplier_address,
            data.supplier_postcode,
            data.supplier_tel,
            data.supplier_email,
            data.supplier_bank,
            data.supplier_account
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //获取供应商列表
    getsupplierlist(client, callback) {
        var sql = `select * from supplier`;
        client.query(sql, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //删除供应商
    deletesupplier(client, data, callback) {
        var sql = `delete from supplier
        where supplier_id=?`
        var params = [
            data.supplier_id
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result)
        })
    },

    //添加进货单
    addwarehousing(client, data, callback) {
        var sql = `insert into warehousing
        ( warehousing_order_id,warehousing_time, goods_id,warehousing_count,total_price,warehousing_staff,supplier)
        values(?,?,?,?,?,?,?);`
        var params = [
            data.warehousing_order_id,
            data.warehousing_time,
            data.goods_id,
            data.warehousing_count,
            data.total_price,
            data.warehousing_staff,
            data.supplier,
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //获取进货单
    getwarehousinglist(client, callback) {
        var sql = `select * from warehousing 
        inner join goods on warehousing.goods_id=goods.goods_id
        inner join supplier on warehousing.supplier=supplier.supplier_id`
        client.query(sql, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //删除进货单
    deletewarehousing(client, data, callback) {
        var sql = `delete from warehousing
        where warehousing_id=?`
        var params = [
            data.warehousing_id
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result)
        })
    },

    //按ID获取商品详情
    getgoodsdetail(client, data, callback) {
        var sql = `select * from goods
        where goods_id=?`
        var params = [
            data.goods_id
        ];

        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result)
        })
    },

    //添加购物车
    addcart(client, data, callback) {
        var sql = `insert into cart
        ( goods_id,user_id, goods_count,addcart_time)
        values(?,?,?,?);`
        var params = [
            data.goods_id,
            data.user_id,
            data.goods_count,
            data.addcart_time,
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //按ID获取购物车
    getcart(client, data, callback) {
        var sql = `select *
        from cart
        inner join user on cart.user_id=user.user_id
        inner join goods on cart.goods_id=goods.goods_id
        where cart.user_id= ?`
        var params = [
            data.user_id
        ];

        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result)
        })
    },

    //删除购物车
    deletecart(client, data, callback) {
        var sql = `delete from cart
        where cart_id=?`
        var params = [
            data.cart_id
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result)
        })
    },

    //添加订单
    addorder(client, data, callback) {
        var sql = `insert into \`order\`
         (order_no,goods_id,product_count,product_amount_total,order_amount_total,logistics,logistics_fee,address_id,pay_channel,addorder_time,user_id,user_remarks) 
        values(?,?,?,?,?,?,?,?,?,?,?,?);`
        var params = [
            data.order_no,
            parseInt(data.goods_id),
            data.product_count,
            data.product_amount_total,
            data.order_amount_total,
            data.logistics,
            data.logistics_fee,
            parseInt(data.address_id),
            data.pay_channel,
            data.addorder_time,
            parseInt(data.user_id),
            data.user_remarks
        ];
        client.query(sql, params, (err, result) => {
            if (err) {
                throw err
            }
            callback(result);
        })
    },

    //添加发票
    addinvoice(client, data, callback) {
        var sql = `insert into order_invoice
        ( invoice_id,addinvoice_time,order_id)
        values(?,?,?);`
        var params = [
            data.invoice_id,
            data.addinvoice_time,
            parseInt(data.order_id)
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //确定支付
    updateorder(client, data, callback) {
        var sql = `update \`order\` set 
        invoice=?,invoice_id=?,out_trade_no=?,payed_time=?,order_status=?
        where order_id = ?`
        var params = [
            data.invoice,
            data.invoice_id,
            data.out_trade_no,
            data.payed_time,
            data.order_status,
            parseInt(data.order_id),
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //获取订单列表
    getorderlist(client, callback) {
        var sql = `select * from \`order\`
                    inner join user on order.user_id=user.user_id
                    inner join goods on order.goods_id=goods.goods_id
                    inner join address on order.address_id=address.address_id`
        client.query(sql, (err, result) => {
            if (err) throw err
            callback(result)
        })
    },

    //按ID获取订单
    getorder(client, data, callback) {
        var sql = `select * from \`order\`
                    inner join user on order.user_id=user.user_id
                    inner join goods on order.goods_id=goods.goods_id
                    inner join address on order.address_id=address.address_id
                    left join order_invoice on order.invoice_id=order_invoice.invoice_id
                    left join order_logistics on order.order_logistics_id=order_logistics.order_logistics_id
                    where order.order_id= ?`
        var params = [
            parseInt(data.order_id)
        ];
        console.log(params)
        client.query(sql, params, (err, result) => {
            if (err) throw err
            console.log(result)
            callback(result)
        })
    },

    //删除订单
    deleteorder(client, data, callback) {
        var sql = `delete from \`order\`
        where order_id=?`
        var params = [
            parseInt(data.order_id)
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result)
        })
    },

    //添加物流
    addorderlogistics(client, data, callback) {
        var sql = `insert into order_logistics
        ( order_id,express_no,logistics,logistics_fee,delivery_time)
        values(?,?,?,?,?);`
        var params = [
            data.order_id,
            data.express_no,
            data.logistics,
            data.logistics_fee,
            data.delivery_time
        ];
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })
    },

    //发货
    delivergoods(client, data, callback) {
        var sql = `update \`order\` set
        order_status=?,order_logistics_id=?,delivery_time=?
        where order_id = ?`
        var params = [
            data.order_status,
            data.order_logistics_id,
            data.delivery_time,
            data.order_id
        ]
        client.query(sql, params, (err, result) => {
            if (err) throw err
            callback(result);
        })

    }
}