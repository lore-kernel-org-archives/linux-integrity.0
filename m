Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795271966;
	b=C9PtEIWjQ+6Fp7nvdW/29ycl4BLOdzFiZWiijhOdqd7ZkIjKyf0VPHwa6RRIDQDcylGT
	 /b4Hk5MpWK6korFVVdNKV5m3WWf0iDftNdA37gwjcShu+a6WvvgVfmdDhuBYY/46uIYo6
	 JIalCt+stBV4CAt7neG+V4DU8IrV+lbwmUn3bMYB4nw0iJ4i8YBjPjYwYQ6r8AYQCeQXE
	 HznbtPmOB1KiGgM4IkEli8wiBnn72NNmb/UsNVhSY0Atho5sx9wAw3odk6vwneCW/oXFm
	 6VcnV5rOCRUU4XXu40aBCswvDjZBtBN2zaFleVfztC5LdvJ28CMXWMWI733MKEKkjVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795271966;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZEPuqkmc8a3AGQ/gPGMBFD+xBYlSccuofNCM9qgA1q4=;
	b=jJxO6JriG5drB9e3wNI4vMHDnAN2/C+6VtkfMo4fvUK8kS9sBeOPG7Nl6shO5m3INt26
	 0mJsZBlqkPPe1ac7OV2SMM+oogU+rzecOV2t2zvfuCpABxD1/zccelvWGJxJPGLk9EW3f
	 WcULUse5S5Hc9nRmiK2W+u1R6IFYMeMazr1pZUM013/nHVGwQn5lsQTXH1XVaAuPZl69R
	 Qv5f9+nd1d9d11VFaZit9G+HLeo8lhIHfRzRgluDhnDDyIwdnC6KBicW5DhyQ8b5yAgN6
	 pgHyEKrgyQyzGpJFD0ZRmrQHYRGY3OWCP9QBRHbAoUmEJP2uGMYwp8dtMzjJ9Y1TB4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTY9k87a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A74C3606A331;
	Sat, 21 Nov 2026 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTY9k87a
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E20981F000C6;
	Sat, 21 Nov 2026 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795271966;
	bh=ZEPuqkmc8a3AGQ/gPGMBFD+xBYlSccuofNCM9qgA1q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bTY9k87aO3700UdY/Cir+4509ON4pgEWPICPRMT3hIad4xE5rxI5QBCFIm8WktWZl
	 f+8qFdez1JCwbrqaRGX4376oMaPFH0Vov1SXigEiH8QQUF3iUNPq1NDVC2pc05su1S
	 cRTuSlxoa0w4bFCqU9u55JCLpow8jRV/t0dMexViswvTjypbfG2MpGwluHpmW7Bs0Q
	 4Lrn7kRvTVU8H8ZAvhiGlpTe9ubYDlcFob7mLvw0Jw8H2rTzgUefn2kSSdUiTPz05t
	 481nVT7tQDDPe8NxHhHjeh1g9S0KdhGjzhfzqfWvMWGJPyBrOlY0gptG2ZTT5bHQFO
	 EmTUw71Wq2zTQ==
Date: Sat, 21 Nov 2026 16:39:22 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 2/3] tpm: Introduce Qualcomm TPM driver
Message-ID: <awGtGoxtker8a9kG@kernel.org>
References: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
 <20261120-tpm_qcom_driver-v5-2-3d9321ace107@oss.qualcomm.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-tpm_qcom_driver-v5-2-3d9321ace107@oss.qualcomm.com>

On Fri, Nov 20, 2026 at 04:23:33PM +0530, Kuldeep Singh wrote:
> Add a TPM chip driver for platforms where a TPM 2.0 instance is
> implemented by a Trusted Application (TA) running in Qualcomm's Trusted
> Execution Environment (QTEE), reachable over the QCOMTEE object-IPC
> transport.
> 
> The driver discovers the qcom.tz.tpm TEE-bus device, opens a session
> with the TPM TA, and register with tpm interface. This exposes the TA
> through the standard /dev/tpm interface and the existing tpm2 command
> layer. OS need not be aware underlying TPM instance is dTPM or fTPM.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
>  drivers/char/tpm/Kconfig    |   9 +
>  drivers/char/tpm/Makefile   |   1 +
>  drivers/char/tpm/tpm_qcom.c | 410 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 420 insertions(+)
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 5f672f2c01b0..05d704ed3632 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -243,6 +243,15 @@ config TCG_FTPM_TEE
>  	help
>  	  This driver proxies for firmware TPM running in TEE.
>  
> +config TCG_QCOM
> +	tristate "Qualcomm TEE based TPM Interface"
> +	depends on QCOMTEE
> +	help
> +	  This driver provides interface to run TPM instances with Trustzone
> +	  having Qualcomm TPM TA running in Qualcomm TEE.
> +	  The mechanism uses the object-IPC based transport provided by
> +	  QCOMTEE.
> +
>  config TCG_SVSM
>  	tristate "SNP SVSM vTPM interface"
>  	depends on AMD_MEM_ENCRYPT
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 5b5cdc0d32e4..471cbf49afd2 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -45,5 +45,6 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>  obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> +obj-$(CONFIG_TCG_QCOM) += tpm_qcom.o
>  obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
>  obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
> diff --git a/drivers/char/tpm/tpm_qcom.c b/drivers/char/tpm/tpm_qcom.c
> new file mode 100644
> index 000000000000..4be939134ea1
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_qcom.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
> +#include <linux/tee.h>
> +#include <linux/tee_drv.h>
> +#include <linux/tpm.h>
> +#include <linux/uuid.h>
> +
> +#include "tpm.h"
> +
> +#define QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS	5
> +#define QCOMTEE_OP_CLIENT_ENV_OPEN		0
> +#define QCOMTEE_MSG_OBJECT_OP_RELEASE		GENMASK(15, 0)
> +
> +#define QCOMTEE_TPM_OP_SEND_COMMAND	0
> +
> +/* UID of the "qcom.tz.tpm" service */
> +#define QCOMTEE_TPM_UID			81
> +
> +/* Max buffer size supported by TPM TA */
> +#define TPM_QCOM_REQ_RSP_SIZE		SZ_4K
> +
> +#define QCOMTEE_TPM_GET_TA_VERSION_ID	0x1000U
> +#define QCOMTEE_TPM_TA_VERSION_MAJOR	GENMASK(31, 16)
> +#define QCOMTEE_TPM_TA_VERSION_MINOR	GENMASK(15, 0)
> +
> +struct tpm_qcom_ta_version_req {
> +	u32 command_id;
> +} __packed;
> +
> +struct tpm_qcom_ta_version_resp {
> +	u32 status;
> +	u32 command_id;
> +	u32 version_num;
> +} __packed;
> +
> +#define QCOMTEE_TPM_TYPE_ID		0x80000U
> +#define QCOMTEE_TPM_TYPE_DTPM		0x6454504dU
> +#define QCOMTEE_TPM_TYPE_FTPM		0x6654504dU
> +
> +struct tpm_qcom_type_req {
> +	u32 command_id;
> +} __packed;
> +
> +struct tpm_qcom_type_resp {
> +	u32 command_id;
> +	u32 status;
> +	u32 tpm_type;
> +} __packed;
> +
> +/*
> + * dTPM SPI transfer optimization:
> + * TRANSFER_START before a burst of commands, TRANSFER_END once done.
> + */
> +#define QCOMTEE_TPM_TRANSFER_ID		0x2U
> +#define QCOMTEE_TPM_TRANSFER_END	0
> +#define QCOMTEE_TPM_TRANSFER_START	1
> +
> +struct tpm_qcom_transfer_req {
> +	u32 command_id;
> +	u32 transfer_state;
> +} __packed;
> +
> +struct tpm_qcom_transfer_resp {
> +	u32 command_id;
> +	u32 status;
> +} __packed;
> +
> +struct tpm_qcom_private {
> +	struct tpm_chip *chip;
> +	struct device *dev;
> +	struct tee_context *ctx;
> +	struct tee_param_objref tpm_svc_obj;
> +	bool is_dtpm;
> +};
> +
> +/* UUID of the QTEE-bus device representing the TPM TA. */
> +static const uuid_t tpm_qcom_uuid =
> +	UUID_INIT(0xaabcb593, 0x7083, 0x5536,
> +		  0xac, 0x27, 0x3d, 0x2d, 0x89, 0x41, 0x9d, 0xdb);
> +
> +static void tpm_qcom_release_object(struct tee_context *ctx,
> +				    struct tee_param_objref object)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
> +
> +	inv_arg.id = object.id;
> +	inv_arg.op = QCOMTEE_MSG_OBJECT_OP_RELEASE;
> +	inv_arg.num_params = 0;
> +
> +	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
> +}
> +
> +static int tpm_qcom_get_client_env_obj(struct device *dev,
> +				       struct tee_context *ctx,
> +				       struct tee_param_objref *client_env_obj)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
> +	struct tee_param param[2] = {};
> +	int ret;
> +
> +	inv_arg.id = TEE_OBJREF_NULL;
> +	inv_arg.op = QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS;
> +	inv_arg.num_params = 2;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT;
> +	param[0].u.objref.id = TEE_OBJREF_NULL;
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
> +
> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "get client env obj failed: ret=%d, invoke_ret=0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: -EIO;
> +	}
> +
> +	*client_env_obj = param[1].u.objref;
> +	return 0;
> +}
> +
> +static int tpm_qcom_get_svc_obj(struct device *dev,
> +				struct tee_context *ctx,
> +				struct tee_param_objref client_env_obj,
> +				struct tee_param_objref *tpm_svc_obj)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
> +	struct tee_param param[2] = {};
> +	u32 tpm_uid = QCOMTEE_TPM_UID;
> +	int ret;
> +
> +	inv_arg.id = client_env_obj.id;
> +	inv_arg.op = QCOMTEE_OP_CLIENT_ENV_OPEN;
> +	inv_arg.num_params = 2;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
> +	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &tpm_uid,
> +						    .size = sizeof(tpm_uid) };
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
> +
> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "get TPM service obj failed: ret=%d, invoke_ret=0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: -EIO;
> +	}
> +
> +	*tpm_svc_obj = param[1].u.objref;
> +	return 0;
> +}
> +
> +static int tpm_qcom_send_command(struct tpm_qcom_private *pvt_data,
> +				 void *req, size_t req_len, void *resp,
> +				 size_t *resp_len)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
> +	struct tee_param param[3] = {};
> +	u8 locality_arg = 0;
> +	int ret;
> +
> +	inv_arg.id = pvt_data->tpm_svc_obj.id;
> +	inv_arg.op = QCOMTEE_TPM_OP_SEND_COMMAND;
> +	inv_arg.num_params = 3;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
> +	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &locality_arg,
> +						   .size = sizeof(locality_arg) };
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
> +	param[1].u.ubuf = (struct tee_param_ubuf){ .addr = req, .size = req_len };
> +	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT;
> +	param[2].u.ubuf = (struct tee_param_ubuf){ .addr = resp, .size = *resp_len };
> +
> +	ret = tee_client_object_invoke_func(pvt_data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(pvt_data->dev,
> +			"send_command invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: -EINVAL;
> +	}
> +
> +	*resp_len = param[2].u.ubuf.size;
> +
> +	return 0;
> +}
> +
> +static int tpm_qcom_get_ta_details(struct tpm_qcom_private *pvt_data)
> +{
> +	struct tpm_qcom_ta_version_req ver_req = {
> +		.command_id = QCOMTEE_TPM_GET_TA_VERSION_ID,
> +	};
> +	struct tpm_qcom_ta_version_resp ver_resp;
> +	size_t resp_len = sizeof(ver_resp);
> +	struct tpm_qcom_type_req type_req = {
> +		.command_id = QCOMTEE_TPM_TYPE_ID,
> +	};
> +	struct tpm_qcom_type_resp type_resp;
> +	int ret;
> +
> +	ret = tpm_qcom_send_command(pvt_data, &ver_req, sizeof(ver_req),
> +				    &ver_resp, &resp_len);
> +	if (ret < 0 || resp_len < sizeof(ver_resp) || ver_resp.status != 0)
> +		return ret ?: -EIO;
> +
> +	dev_info(pvt_data->dev, "TPM TA version %lu.%lu\n",
> +		 FIELD_GET(QCOMTEE_TPM_TA_VERSION_MAJOR, ver_resp.version_num),
> +		 FIELD_GET(QCOMTEE_TPM_TA_VERSION_MINOR, ver_resp.version_num));
> +
> +	resp_len = sizeof(type_resp);
> +	ret = tpm_qcom_send_command(pvt_data, &type_req, sizeof(type_req),
> +				    &type_resp, &resp_len);
> +	if (ret < 0 || resp_len < sizeof(type_resp) || type_resp.status != 0)
> +		return ret ?: -EIO;
> +
> +	switch (type_resp.tpm_type) {
> +	case QCOMTEE_TPM_TYPE_FTPM:
> +		dev_info(pvt_data->dev, "TPM type: fTPM\n");
> +		pvt_data->is_dtpm = false;
> +		break;
> +	case QCOMTEE_TPM_TYPE_DTPM:
> +		dev_info(pvt_data->dev, "TPM type: dTPM\n");
> +		pvt_data->is_dtpm = true;
> +		break;
> +	default:
> +		dev_err(pvt_data->dev, "unsupported TPM type: 0x%08x\n",
> +			type_resp.tpm_type);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/* fTPM does not implement this command and to be invoked via dtpm only. */
> +static int tpm_qcom_transfer(struct tpm_qcom_private *pvt_data,
> +			     u32 transfer_state)
> +{
> +	struct tpm_qcom_transfer_req req = {
> +		.command_id = QCOMTEE_TPM_TRANSFER_ID,
> +		.transfer_state = transfer_state,
> +	};
> +	struct tpm_qcom_transfer_resp resp;
> +	size_t resp_len = sizeof(resp);
> +	int ret;
> +
> +	ret = tpm_qcom_send_command(pvt_data, &req, sizeof(req), &resp,
> +				    &resp_len);
> +	if (ret < 0 || resp_len < sizeof(resp) || resp.status != 0)
> +		return ret ?: -EIO;
> +
> +	return 0;
> +}
> +
> +static int tpm_qcom_cmd_ready(struct tpm_chip *chip)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +
> +	if (!pvt_data->is_dtpm)
> +		return 0;
> +
> +	return tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_START);
> +}
> +
> +static int tpm_qcom_go_idle(struct tpm_chip *chip)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +
> +	if (!pvt_data->is_dtpm)
> +		return 0;
> +
> +	return tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_END);
> +}
> +
> +/*
> + * The raw TPM2 command in @buf is sent directly as send_command's UBUF-in
> + * param and the raw TPM2 response is read back from its UBUF-out param.
> + */
> +static int tpm_qcom_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
> +			 size_t cmd_len)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +	struct tpm_header *header = (struct tpm_header *)buf;
> +	size_t resp_len = min_t(size_t, bufsiz, TPM_QCOM_REQ_RSP_SIZE);
> +	int ret;
> +
> +	if (cmd_len > TPM_QCOM_REQ_RSP_SIZE)
> +		return -EIO;
> +
> +	u8 *response __free(kfree) = kzalloc(resp_len, GFP_KERNEL);
> +	if (!response)
> +		return -ENOMEM;
> +
> +	ret = tpm_qcom_send_command(pvt_data, buf, cmd_len, response, &resp_len);
> +	if (ret < 0 || resp_len > bufsiz) {
> +		dev_err(&chip->dev,
> +			"TPM command failed: cmd_len=%zu, tpm_cc=0x%08x, ret=%d, resp_len=%zu, bufsiz=%zu\n",
> +			cmd_len, be32_to_cpu(header->ordinal), ret, resp_len, bufsiz);
> +		return ret ?: -EIO;
> +	}
> +
> +	memcpy(buf, response, resp_len);
> +	return resp_len;
> +}
> +
> +static const struct tpm_class_ops tpm_qcom_ops = {
> +	.flags = TPM_OPS_AUTO_STARTUP,
> +	.send = tpm_qcom_send,
> +	.cmd_ready = tpm_qcom_cmd_ready,
> +	.go_idle = tpm_qcom_go_idle,
> +};
> +
> +static int tpm_qcom_ctx_match(struct tee_ioctl_version_data *ver,
> +			      const void *data)
> +{
> +	return (ver->impl_id == TEE_IMPL_ID_QTEE);
> +}
> +
> +static int tpm_qcom_probe(struct tee_client_device *tee_dev)
> +{
> +	struct device *dev = &tee_dev->dev;
> +	struct tpm_qcom_private *pvt_data;
> +	struct tee_param_objref client_env_obj;
> +	struct tee_param_objref tpm_svc_obj;
> +	struct tpm_chip *chip;
> +	int err;
> +
> +	pvt_data = devm_kzalloc(dev, sizeof(*pvt_data), GFP_KERNEL);
> +	if (!pvt_data)
> +		return -ENOMEM;
> +
> +	pvt_data->dev = dev;
> +
> +	pvt_data->ctx = tee_client_open_context(NULL, tpm_qcom_ctx_match, NULL, NULL);
> +	if (IS_ERR(pvt_data->ctx))
> +		return dev_err_probe(dev, PTR_ERR(pvt_data->ctx),
> +				     "tee_client_open_context failed\n");
> +
> +	err = tpm_qcom_get_client_env_obj(dev, pvt_data->ctx, &client_env_obj);
> +	if (err)
> +		goto out_ctx;
> +
> +	err = tpm_qcom_get_svc_obj(dev, pvt_data->ctx, client_env_obj, &tpm_svc_obj);
> +	/* Release client_env object irrespective of service obj return status */
> +	tpm_qcom_release_object(pvt_data->ctx, client_env_obj);
> +	if (err)
> +		goto out_ctx;
> +
> +	pvt_data->tpm_svc_obj = tpm_svc_obj;
> +	err = tpm_qcom_get_ta_details(pvt_data);
> +	if (err)
> +		goto out_svc_obj;
> +
> +	chip = tpmm_chip_alloc(dev, &tpm_qcom_ops);
> +	if (IS_ERR(chip)) {
> +		err = dev_err_probe(dev, PTR_ERR(chip), "tpmm_chip_alloc failed\n");
> +		goto out_svc_obj;
> +	}
> +
> +	pvt_data->chip = chip;
> +	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
> +	dev_set_drvdata(dev, pvt_data);
> +
> +	err = tpm_chip_register(pvt_data->chip);
> +	if (err) {
> +		dev_err_probe(dev, err, "tpm_chip_register failed\n");
> +		goto out_svc_obj;
> +	}
> +
> +	return 0;
> +
> +out_svc_obj:
> +	tpm_qcom_release_object(pvt_data->ctx, tpm_svc_obj);
> +
> +out_ctx:
> +	tee_client_close_context(pvt_data->ctx);
> +	return err;
> +}
> +
> +static void tpm_qcom_remove(struct tee_client_device *tee_dev)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(&tee_dev->dev);
> +
> +	tpm_chip_unregister(pvt_data->chip);
> +	tpm_qcom_release_object(pvt_data->ctx, pvt_data->tpm_svc_obj);
> +	tee_client_close_context(pvt_data->ctx);
> +}
> +
> +static const struct tee_client_device_id tpm_qcom_id_table[] = {
> +	{ tpm_qcom_uuid },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(tee, tpm_qcom_id_table);
> +
> +static struct tee_client_driver tpm_qcom_driver = {
> +	.id_table	= tpm_qcom_id_table,
> +	.probe		= tpm_qcom_probe,
> +	.remove		= tpm_qcom_remove,
> +	.driver		= {
> +		.name	= "tpm_qcom",
> +	},
> +};
> +
> +module_tee_client_driver(tpm_qcom_driver);
> +
> +MODULE_DESCRIPTION("TPM driver for Qualcomm TPM TA");
> +MODULE_AUTHOR("Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>");

MODULE_AUTHOR() field is not that useful and nobody keeps it up to
date, so you never can rely on it. Not NAK, but just underlining
how litte it is worth :-)

Copyright and authorship is anyhow recorded by Git and
MAINTAINERS document.

> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.34.1


> 
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
