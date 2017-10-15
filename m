Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751109AbdJOO1u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 15 Oct 2017 10:27:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9FEOOo8051645
        for <linux-integrity@vger.kernel.org>; Sun, 15 Oct 2017 10:27:50 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dkes9bvkg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 15 Oct 2017 10:27:49 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 15 Oct 2017 15:27:48 +0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9FERicm27918530
        for <linux-integrity@vger.kernel.org>; Sun, 15 Oct 2017 14:27:45 GMT
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
        by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9FERZtP010222
        for <linux-integrity@vger.kernel.org>; Mon, 16 Oct 2017 01:27:35 +1100
Subject: Re: [PATCH V2] EVM: Allow userspace to signal an RSA key has been
 loaded
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Sun, 15 Oct 2017 10:27:41 -0400
In-Reply-To: <20171011191014.4426-1-mjg59@google.com>
References: <20171011191014.4426-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508077661.3426.143.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2017-10-11 at 12:10 -0700, Matthew Garrett wrote:
> EVM will only perform validation once a key has been loaded. This key
> may either be a symmetric trusted key (for HMAC validation and creation)
> or the public half of an asymmetric key (for digital signature
> validation). The /sys/kernel/security/evm interface allows userland to
> signal that a symmetric key has been loaded, but does not allow userland
> to signal that an asymmetric public key has been loaded.
> 
> This patch extends the interface to permit userspace to pass a bitmask
> of loaded key types. It also allows userspace to block loading of an
> asymmetric key in order to avoid a compromised system from being able to
> load an additional key type later.

I assume you mean "block loading of a symmetric key".  Other than this
and a trailing blank line, the patch looks good.  If you don't have
objections, I'll fix these two things.

Mimi  

> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  Documentation/ABI/testing/evm      | 48 +++++++++++++++++++++++++++-----------
>  security/integrity/evm/evm.h       |  3 +++
>  security/integrity/evm/evm_secfs.c | 29 +++++++++++++----------
>  3 files changed, 54 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
> index 8374d4557e5d..d2782afb0d96 100644
> --- a/Documentation/ABI/testing/evm
> +++ b/Documentation/ABI/testing/evm
> @@ -7,17 +7,37 @@ Description:
>  		HMAC-sha1 value across the extended attributes, storing the
>  		value as the extended attribute 'security.evm'.
> 
> -		EVM depends on the Kernel Key Retention System to provide it
> -		with a trusted/encrypted key for the HMAC-sha1 operation.
> -		The key is loaded onto the root's keyring using keyctl.  Until
> -		EVM receives notification that the key has been successfully
> -		loaded onto the keyring (echo 1 > <securityfs>/evm), EVM
> -		can not create or validate the 'security.evm' xattr, but
> -		returns INTEGRITY_UNKNOWN.  Loading the key and signaling EVM
> -		should be done as early as possible.  Normally this is done
> -		in the initramfs, which has already been measured as part
> -		of the trusted boot.  For more information on creating and
> -		loading existing trusted/encrypted keys, refer to:
> -		Documentation/keys-trusted-encrypted.txt.  (A sample dracut
> -		patch, which loads the trusted/encrypted key and enables
> -		EVM, is available from http://linux-ima.sourceforge.net/#EVM.)
> +		EVM supports two classes of security.evm. The first is
> +		an HMAC-sha1 generated locally with a
> +		trusted/encrypted key stored in the Kernel Key
> +		Retention System. The second is a digital signature
> +		generated either locally or remotely using an
> +		asymmetric key. These keys are loaded onto root's
> +		keyring using keyctl, and EVM is then enabled by
> +		echoing a value to <securityfs>/evm:
> +
> +		1: enable HMAC validation and creation
> +		2: enable digital signature validation
> +		3: enable HMAC and digital signature validation and HMAC
> +		   creation
> +
> +		Further writes will be blocked if HMAC support is enabled or
> +		if bit 32 is set:
> +
> +		echo 0x80000002 ><securityfs>/evm
> +
> +		will enable digital signature validation and block
> +		further writes to <securityfs>/evm.
> +
> +		Until this is done, EVM can not create or validate the
> +		'security.evm' xattr, but returns INTEGRITY_UNKNOWN.
> +		Loading keys and signaling EVM should be done as early
> +		as possible.  Normally this is done in the initramfs,
> +		which has already been measured as part of the trusted
> +		boot.  For more information on creating and loading
> +		existing trusted/encrypted keys, refer to:
> +		Documentation/keys-trusted-encrypted.txt. Both dracut
> +		(via 97masterkey and 98integrity) and systemd (via
> +		core/ima-setup) have support for loading keys at boot
> +		time.
> +
> diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
> index 2ff02459fcfd..946efffcc389 100644
> --- a/security/integrity/evm/evm.h
> +++ b/security/integrity/evm/evm.h
> @@ -23,6 +23,9 @@
> 
>  #define EVM_INIT_HMAC	0x0001
>  #define EVM_INIT_X509	0x0002
> +#define EVM_SETUP       0x80000000 /* userland has signaled key load */
> +
> +#define EVM_INIT_MASK (EVM_INIT_HMAC | EVM_INIT_X509 | EVM_SETUP)
> 
>  extern int evm_initialized;
>  extern char *evm_hmac;
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index c8dccd54d501..319cf16d6603 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -40,7 +40,7 @@ static ssize_t evm_read_key(struct file *filp, char __user *buf,
>  	if (*ppos != 0)
>  		return 0;
> 
> -	sprintf(temp, "%d", evm_initialized);
> +	sprintf(temp, "%d", (evm_initialized & ~EVM_SETUP));
>  	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
> 
>  	return rc;
> @@ -61,24 +61,29 @@ static ssize_t evm_read_key(struct file *filp, char __user *buf,
>  static ssize_t evm_write_key(struct file *file, const char __user *buf,
>  			     size_t count, loff_t *ppos)
>  {
> -	char temp[80];
> -	int i;
> +	int i, ret;
> 
> -	if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_INIT_HMAC))
> +	if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP))
>  		return -EPERM;
> 
> -	if (count >= sizeof(temp) || count == 0)
> -		return -EINVAL;
> -
> -	if (copy_from_user(temp, buf, count) != 0)
> -		return -EFAULT;
> +	ret = kstrtoint_from_user(buf, count, 0, &i);
> 
> -	temp[count] = '\0';
> +	if (ret)
> +		return ret;
> 
> -	if ((sscanf(temp, "%d", &i) != 1) || (i != 1))
> +	/* Reject invalid values */
> +	if (!i || (i & ~EVM_INIT_MASK) != 0)
>  		return -EINVAL;
> 
> -	evm_init_key();
> +	if (i & EVM_INIT_HMAC) {
> +		ret = evm_init_key();
> +		if (ret != 0)
> +			return ret;
> +		/* Forbid further writes after the symmetric key is loaded */
> +		i |= EVM_SETUP;
> +	}
> +
> +	evm_initialized |= i;
> 
>  	return count;
>  }
