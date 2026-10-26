Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045244;
	b=XBAMQ6x14OCIiErn+e3aHFyeUWMBww9DUBSRVyIc41hZdhH5yQZ35YTsvweRb1gxKWnb
	 J2Zxh7CprB6Jq0f3G482v6X7Ib3+jpwN9ZClHblxSpjcaNsCiKO3e1mjbtu20HCzfKA9q
	 dd9BS224EAMUVG7WeiF3iM6BjoKdD8ZwuWei87x9ZHFNUa19A6g8e4Sj52mvvPXQtil+a
	 rLW66v803oxTOAdt3f1fcg8hRBMcMkBCwnXyDl0167zNYGxFElJSFNV+GSvSzlZ95LhAN
	 059KJzQAIwPX/zE2PrHWqt3fgveDu88XXxClueuwXhIaa+vuiQt5huqLbjpV7vAhJDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045244;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uj5ihYuiOE6xUuyIvqMMTcoUU2LniRqloeymakP+p5M=;
	b=HgC4L6JTD2kELftcU0kojJu5z/JylqKW9GyTixKtZYRJZqFGLixOtxfD++NwTOUMH2Hr
	 xs69Od0LwSJkAR9y0RPdEqf12dDtUE0LVzwxkfDRzCgBFj7S8XPw3lKnNFwy+kBYeg5vB
	 ASJyQQrHubu3HSln881E6lEv5SGeuWacVfj8J/i7OZiNOYRG3O1w3+k0hmGP+Y1OEoNgr
	 7XzH34Qefk6N7xlxMNh62+1+sx0SVvmvdcFY8jyy8zlOuv5lMmj8G60yaSTcw/64u3GgW
	 RdmdXECt3I4v7Lyhm+vuYtyreVYa/ALxZC8dB8c0k6gsqncEIV6k1YFdetVesAOYS8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a/liiYwn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 75860606A31A;
	Mon, 26 Oct 2026 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/liiYwn
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 88C8F1F01825;
	Mon, 26 Oct 2026 20:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793045244;
	bh=uj5ihYuiOE6xUuyIvqMMTcoUU2LniRqloeymakP+p5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a/liiYwnS7G3lkpstI+deAd9RGuul837r0GLPXA9hTzj0alYjVd5ax6sgO1KO2Jlp
	 51tMHdFi0ISxEYBaH+vgA3nQirj96hwsok5htUdQKDx7j9rSCLP6D47YxpKjvbFUjY
	 JvAEeX6gDuL5Ap7xBcyUzPCjL5p9nED7MaAXLljzwyNayLt+z6VqJUgr4rzgi/GH3z
	 02PJzYAzROwdEYIbDWbSdJKjsxdwCkHFB/qjtWT1PfSq6XfNg/SJAi4F39J3Q+2wli
	 DtB9aF65NMJd+n90rRfByWoaMAPvi0F0cYlERK5af10D56hDkIRwXQrN5g0mbkiSzc
	 4sA/lJcknRtoA==
Date: Mon, 26 Oct 2026 22:07:20 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sumit.garg@oss.qualcomm.com,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/1] tpm: add TEE driver for a discrete TPM behind OP-TEE
Message-ID: <at-y-BtnXX-u67hv@kernel.org>
References: <20261026163259.1900439-1-jorge.ramirez@oss.qualcomm.com>
 <20261026163259.1900439-2-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20261026163259.1900439-2-jorge.ramirez@oss.qualcomm.com>

On Mon, Oct 26, 2026 at 05:32:48PM +0100, Jorge Ramirez-Ortiz wrote:
> Add tpm_dtpm_tee for a discrete TPM that OP-TEE owns and the normal world
> cannot reach directly (e.g. an SPI TPM on a bus driven by OP-TEE). The
> driver binds to OP-TEE's passthrough pseudo TA by UUID and forwards TPM2
> commands through it, presenting a standard TPM2 character device.

"OP-TEE hosts" would be more understandable.

I have trouble following the hops you are doing by speaking about normal
world and then jumping into SPI bus. Please try to somehow make this
more rigid and less terminology decorated.

> 
> It is a separate driver rather than a reuse of tpm_ftpm_tee: the TEE
> transport is the same, but that driver is tied to the Microsoft fTPM TA
> and opens a public-login session, whereas this is a distinct TA for a real
> chip, gated to REE-kernel access so that user space and other TAs cannot
> reach the TPM. Sharing the fTPM identity would conflate two different
> devices and collide on a platform that has both.

And they don't share any of the same DNA?

Two other options:

1. tpm_tis_core type of solution.
2. Implement the feature as part of tpm_ftpm_tee.c.

I don't think tpm_ftpm_tee was that great name choice [1] but we have
to live with it. 

So more logical name as per taxonomy would be probably
tpm_ftpm_tee_dtpm.

> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>  MAINTAINERS                     |   6 +
>  drivers/char/tpm/Kconfig        |  18 ++
>  drivers/char/tpm/Makefile       |   1 +
>  drivers/char/tpm/tpm_dtpm_tee.c | 282 ++++++++++++++++++++++++++++++++
>  4 files changed, 307 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_dtpm_tee.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 782389bd5cd3..2d279f45fcea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27710,6 +27710,12 @@ F:	include/linux/tpm*.h
>  F:	include/uapi/linux/vtpm_proxy.h
>  F:	tools/testing/selftests/tpm2/
>  
> +TPM TEE DRIVER FOR DISCRETE TPM
> +R:	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> +L:	linux-integrity@vger.kernel.org
> +S:	Supported
> +F:	drivers/char/tpm/tpm_dtpm_tee.c
> +
>  TPS546D24 DRIVER
>  M:	Duke Du <dukedu83@gmail.com>
>  L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 5f672f2c01b0..8293e43e4bc0 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -243,6 +243,24 @@ config TCG_FTPM_TEE
>  	help
>  	  This driver proxies for firmware TPM running in TEE.
>  
> +config TCG_DTPM_TEE
> +	tristate "TEE based discrete TPM Interface"
> +	depends on TEE && OPTEE
> +	help
> +	  This driver proxies for a discrete TPM that is owned by OP-TEE and
> +	  reachable only from the secure world (for example an SPI TPM behind
> +	  OP-TEE's TPM TIS driver). OP-TEE exposes a passthrough pseudo TA and
> +	  this driver pipes TPM commands through it, presenting a standard
> +	  TPM character device to the normal world.
> +
> +	  The secure world is the sole owner of the TPM and of the bus it
> +	  sits on. That bus/controller must be disabled in the non-secure
> +	  device tree: disabling only the in-kernel TPM driver (e.g.
> +	  tpm_tis_spi) is not enough, because the normal-world bus controller
> +	  would still drive the engine in parallel with OP-TEE and corrupt
> +	  its transfers. With the bus disabled, the TPM is reached only
> +	  through this driver.
> +
>  config TCG_SVSM
>  	tristate "SNP SVSM vTPM interface"
>  	depends on AMD_MEM_ENCRYPT
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 5b5cdc0d32e4..5c5e20001cac 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -45,5 +45,6 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>  obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> +obj-$(CONFIG_TCG_DTPM_TEE) += tpm_dtpm_tee.o
>  obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
>  obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
> diff --git a/drivers/char/tpm/tpm_dtpm_tee.c b/drivers/char/tpm/tpm_dtpm_tee.c
> new file mode 100644
> index 000000000000..755429ff8a3f
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_dtpm_tee.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * TEE driver for a discrete TPM owned by OP-TEE and exposed to the normal
> + * world through a passthrough pseudo TA. The chip sits on a bus only the
> + * secure world can reach (e.g. SPI behind OP-TEE's TPM TIS driver); the driver
> + * binds the TA by UUID and relays raw TPM2 commands as a standard tpm_chip.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/tee_drv.h>
> +#include <linux/tpm.h>
> +#include <linux/uuid.h>
> +
> +#include "tpm.h"
> +
> +/* Must match the discrete TPM passthrough pseudo TA in OP-TEE */
> +static const uuid_t dtpm_ta_uuid =
> +	UUID_INIT(0x50568cd9, 0x370a, 0x46b8,
> +		  0x9f, 0x2c, 0x6f, 0xd9, 0x06, 0x64, 0xd2, 0xee);
> +
> +#define DTPM_TEE_TA_SUBMIT_COMMAND	0
> +
> +#define DTPM_MAX_COMMAND_SIZE		4096
> +#define DTPM_MAX_RESPONSE_SIZE		4096
> +
> +struct dtpm_tee_private {
> +	struct tpm_chip *chip;
> +	u32 session;
> +	struct tee_context *ctx;
> +	struct tee_shm *shm;
> +};
> +
> +/* Validate the response header the TA wrote back, return its length or -EIO */
> +static int dtpm_tee_resp_len(struct tpm_chip *chip, const u8 *resp,
> +			     size_t bufsiz)
> +{
> +	size_t resp_len = be32_to_cpu(((struct tpm_header *)resp)->length);
> +
> +	if (resp_len < TPM_HEADER_SIZE || resp_len > DTPM_MAX_RESPONSE_SIZE ||
> +	    resp_len > bufsiz) {
> +		dev_err(&chip->dev, "bad response length %zu (buffer %zu)\n",
> +			resp_len, bufsiz);
> +		return -EIO;
> +	}
> +
> +	return resp_len;
> +}
> +
> +/**
> + * dtpm_tee_tpm_op_send() - relay a TPM command through TEE shared memory.
> + * @chip:	the tpm_chip description
> + * @buf:	command on entry, response on return
> + * @bufsiz:	size of @buf
> + * @cmd_len:	number of command bytes to send
> + *
> + * Return: number of response bytes on success, -errno on failure.
> + */
> +static int dtpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
> +				size_t cmd_len)
> +{
> +	struct dtpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +	struct tee_shm *shm = pvt_data->shm;
> +	struct tee_ioctl_invoke_arg transceive_args;

= {};

> +	struct tee_param command_params[4];

= {};

> +	u8 *temp_buf;
> +	int rc;
> +
> +	if (cmd_len > DTPM_MAX_COMMAND_SIZE || cmd_len > bufsiz) {
> +		dev_err(&chip->dev, "command length %zu (buffer %zu)\n",
> +			cmd_len, bufsiz);
> +		return -EIO;
> +	}
> +
> +	memset(&transceive_args, 0, sizeof(transceive_args));
> +	memset(command_params, 0, sizeof(command_params));
> +
> +	transceive_args = (struct tee_ioctl_invoke_arg) {
> +		.func = DTPM_TEE_TA_SUBMIT_COMMAND,
> +		.session = pvt_data->session,
> +		.num_params = 4,
> +	};
> +
> +	/* memref[0]: command in, memref[1]: response in/out */
> +	command_params[0] = (struct tee_param) {
> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> +		.u.memref = {
> +			.shm = shm,
> +			.size = cmd_len,
> +			.shm_offs = 0,
> +		},
> +	};
> +
> +	temp_buf = tee_shm_get_va(shm, 0);
> +	if (IS_ERR(temp_buf)) {
> +		dev_err(&chip->dev, "tee_shm_get_va failed for transmit\n");
> +		return PTR_ERR(temp_buf);
> +	}
> +	memset(temp_buf, 0, DTPM_MAX_COMMAND_SIZE + DTPM_MAX_RESPONSE_SIZE);
> +	memcpy(temp_buf, buf, cmd_len);
> +
> +	command_params[1] = (struct tee_param) {
> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> +		.u.memref = {
> +			.shm = shm,
> +			.size = DTPM_MAX_RESPONSE_SIZE,
> +			.shm_offs = DTPM_MAX_COMMAND_SIZE,
> +		},
> +	};
> +
> +	rc = tee_client_invoke_func(pvt_data->ctx, &transceive_args,
> +				    command_params);
> +	if (rc < 0 || transceive_args.ret != 0) {
> +		dev_err(&chip->dev, "SUBMIT_COMMAND invoke error: 0x%x\n",
> +			transceive_args.ret);
> +		return (rc < 0) ? rc : -EIO;
> +	}
> +
> +	temp_buf = tee_shm_get_va(shm, command_params[1].u.memref.shm_offs);
> +	if (IS_ERR(temp_buf)) {
> +		dev_err(&chip->dev, "tee_shm_get_va failed for receive\n");
> +		return PTR_ERR(temp_buf);
> +	}
> +
> +	rc = dtpm_tee_resp_len(chip, temp_buf, bufsiz);
> +	if (rc < 0)
> +		return rc;
> +
> +	memcpy(buf, temp_buf, rc);
> +
> +	return rc;
> +}
> +
> +static const struct tpm_class_ops dtpm_tee_tpm_ops = {
> +	.flags = TPM_OPS_AUTO_STARTUP,
> +	.send = dtpm_tee_tpm_op_send,
> +};
> +
> +static int dtpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +	/* Only GP-compliant OP-TEE is supported */
> +	if (ver->impl_id == TEE_IMPL_ID_OPTEE && (ver->gen_caps & TEE_GEN_CAP_GP))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * Open the TA session as the REE kernel: the TA gates the shared TPM on
> + * TEE_LOGIN_REE_KERNEL so user space and other TAs cannot submit raw commands.
> + */
> +static int dtpm_tee_open_session(struct device *dev, struct tee_context *ctx,
> +				 u32 *session)
> +{
> +	struct tee_ioctl_open_session_arg sess_arg;
> +	int rc;
> +
> +	memset(&sess_arg, 0, sizeof(sess_arg));
> +	export_uuid(sess_arg.uuid, &dtpm_ta_uuid);
> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> +	sess_arg.num_params = 0;
> +
> +	rc = tee_client_open_session(ctx, &sess_arg, NULL);
> +	if (rc < 0 || sess_arg.ret != 0) {
> +		dev_err(dev, "tee_client_open_session failed, err=0x%x\n",
> +			sess_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	*session = sess_arg.session;
> +
> +	return 0;
> +}
> +
> +static int dtpm_tee_probe(struct tee_client_device *tcdev)
> +{
> +	struct device *dev = &tcdev->dev;
> +	struct dtpm_tee_private *pvt_data;
> +	struct tpm_chip *chip;
> +	int rc;
> +
> +	pvt_data = devm_kzalloc(dev, sizeof(*pvt_data), GFP_KERNEL);
> +	if (!pvt_data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, pvt_data);
> +
> +	pvt_data->ctx = tee_client_open_context(NULL, dtpm_tee_match, NULL,
> +						NULL);
> +	if (IS_ERR(pvt_data->ctx)) {
> +		if (PTR_ERR(pvt_data->ctx) == -ENOENT)
> +			return -EPROBE_DEFER;
> +		dev_err(dev, "tee_client_open_context failed\n");
> +		return PTR_ERR(pvt_data->ctx);
> +	}
> +
> +	rc = dtpm_tee_open_session(dev, pvt_data->ctx, &pvt_data->session);
> +	if (rc)
> +		goto out_tee_session;
> +
> +	pvt_data->shm = tee_shm_alloc_kernel_buf(pvt_data->ctx,
> +						 DTPM_MAX_COMMAND_SIZE +
> +						 DTPM_MAX_RESPONSE_SIZE);
> +	if (IS_ERR(pvt_data->shm)) {
> +		dev_err(dev, "tee_shm_alloc_kernel_buf failed\n");
> +		rc = -ENOMEM;
> +		goto out_shm_alloc;
> +	}
> +
> +	chip = tpm_chip_alloc(dev, &dtpm_tee_tpm_ops);
> +	if (IS_ERR(chip)) {
> +		dev_err(dev, "tpm_chip_alloc failed\n");
> +		rc = PTR_ERR(chip);
> +		goto out_chip_alloc;
> +	}
> +
> +	pvt_data->chip = chip;
> +	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
> +
> +	rc = tpm_chip_register(pvt_data->chip);
> +	if (rc) {
> +		dev_err(dev, "tpm_chip_register failed with rc=%d\n", rc);
> +		goto out_chip;
> +	}
> +
> +	return 0;
> +
> +out_chip:
> +	put_device(&pvt_data->chip->dev);
> +out_chip_alloc:
> +	tee_shm_free(pvt_data->shm);
> +out_shm_alloc:
> +	tee_client_close_session(pvt_data->ctx, pvt_data->session);
> +out_tee_session:
> +	tee_client_close_context(pvt_data->ctx);
> +
> +	return rc;
> +}
> +
> +static void dtpm_tee_remove(struct tee_client_device *tcdev)
> +{
> +	struct dtpm_tee_private *pvt_data = dev_get_drvdata(&tcdev->dev);
> +
> +	tpm_chip_unregister(pvt_data->chip);
> +	put_device(&pvt_data->chip->dev);
> +	tee_shm_free(pvt_data->shm);
> +	tee_client_close_session(pvt_data->ctx, pvt_data->session);
> +	tee_client_close_context(pvt_data->ctx);
> +}
> +
> +static const struct tee_client_device_id dtpm_tee_id_table[] = {
> +	{UUID_INIT(0x50568cd9, 0x370a, 0x46b8,
> +		   0x9f, 0x2c, 0x6f, 0xd9, 0x06, 0x64, 0xd2, 0xee)},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(tee, dtpm_tee_id_table);
> +
> +static struct tee_client_driver dtpm_tee_driver = {
> +	.probe		= dtpm_tee_probe,
> +	.remove		= dtpm_tee_remove,
> +	.id_table	= dtpm_tee_id_table,
> +	.driver		= {
> +		.name		= "optee-dtpm",
> +	},
> +};
> +
> +static int __init dtpm_tee_mod_init(void)
> +{
> +	return tee_client_driver_register(&dtpm_tee_driver);
> +}
> +
> +static void __exit dtpm_tee_mod_exit(void)
> +{
> +	tee_client_driver_unregister(&dtpm_tee_driver);
> +}
> +
> +module_init(dtpm_tee_mod_init);
> +module_exit(dtpm_tee_mod_exit);

Maybe it would make sense use the module name as prefix here,
and across the board.


> +
> +MODULE_DESCRIPTION("TPM Driver for a discrete TPM behind OP-TEE");

Not liking this but right nothing comes to mind. Might also depend
on how this is laid out in the end.

> +MODULE_LICENSE("GPL");
> -- 
> 2.55.0
> 

[1] Please read this too:
    https://lore.kernel.org/linux-integrity/aqGDL2qZ0sZNMG0f@kernel.org/

Br, Jarkko
