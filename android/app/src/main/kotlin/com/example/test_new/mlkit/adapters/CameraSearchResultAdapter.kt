package com.webkul.magento.mlkit.adapters

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.example.test_new.R
import com.example.test_new.databinding.CameraSimpleSpinnerItemBinding
import com.webkul.magento.mlkit.activities.CameraSearchActivity





class CameraSearchResultAdapter(
        private val context: CameraSearchActivity,
        private val labelList: List<String>
) : RecyclerView.Adapter<CameraSearchResultAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view =
            LayoutInflater.from(context).inflate(R.layout.camera_simple_spinner_item, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.mBinding?.labelTv?.text = labelList[position]
        holder.mBinding?.labelTv?.setOnClickListener { context.sendResultBack(position) }

    }

    override fun getItemCount() = labelList.size


    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val mBinding: CameraSimpleSpinnerItemBinding? = DataBindingUtil.bind(itemView)

    }


}
