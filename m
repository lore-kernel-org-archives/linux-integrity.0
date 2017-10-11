Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751644AbdJKOCQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Oct 2017 10:02:16 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9BDws3a122105
        for <linux-integrity@vger.kernel.org>; Wed, 11 Oct 2017 10:02:16 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dhk0hq25e-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 11 Oct 2017 10:02:15 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 11 Oct 2017 15:02:14 +0100
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9BE2AoP15204526
        for <linux-integrity@vger.kernel.org>; Wed, 11 Oct 2017 14:02:11 GMT
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
        by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9BE29d1003747
        for <linux-integrity@vger.kernel.org>; Thu, 12 Oct 2017 01:02:09 +1100
Subject: Re: [PATCH] EVM: Allow userspace to signal an RSA key has been
 loaded
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Wed, 11 Oct 2017 10:02:06 -0400
In-Reply-To: <20171010222609.5185-1-mjg59@google.com>
References: <20171010222609.5185-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1507730526.3426.22.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2017-10-10 at 15:26 -0700, Matthew Garrett wrote:
> EVM will only perform validation once a key has been loaded. This key
> may either be a symmetric trusted key (for HMAC validation and creation)
> or the public half of an asymmetric key (for digital signature
> validation). The /sys/kernel/security/evm interface allows userland to
> signal that a symmetric key has been loaded, but does not allow userland
> to signal that an asymmetric public key has been loaded.
> 
> This patch extends the interface to permit userspace to pass a bitmask
> of loaded key types. It is a write-once interface in order to avoid a
> compromised system from being able to load an additional key type later.

Let's be a bit more precise.  It only prevents loading the EVM
symmetric key.  I'm a bit concerned about this restriction, not that
there is a restriction, but that it is automatic.

Let's take a hypothetical scenario, where the asymmetric key is
available early, but the symmetric key is available later due to
hardware.  In this scenario, we would want to load and start
appraising early, with the ability of loading the EVM symmetric later.

With CONFIG_EVM_LOAD_X509, the initial asymmetric is loaded and the
subsequent symmetric key can still be loaded, as EVM_SETUP is not
enabled.

I think preventing userspace from loading an EVM symmetric key, is
fine, but it shouldn't be done automatically on their behalf.


> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  Documentation/ABI/testing/evm      | 39 ++++++++++++++++++++++++--------------
>  security/integrity/evm/evm.h       |  3 +++
>  security/integrity/evm/evm_secfs.c | 27 ++++++++++++++------------
>  3 files changed, 43 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
> index 8374d4557e5d..0463c3339bb1 100644
> --- a/Documentation/ABI/testing/evm
> +++ b/Documentation/ABI/testing/evm
> @@ -7,17 +7,28 @@ Description:
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
> +		Until this is done, EVM can not create or validate the
> +		'security.evm' xattr, but returns INTEGRITY_UNKNOWN.
> +		Loading keys and signaling EVM should be done as early
> +		as possible.  Normally this is done in the initramfs,
> +		which has already been measured as part of the trusted
> +		boot.  For more information on creating and loading
> +		existing trusted/encrypted keys, refer to:
> +		Documentation/keys-trusted-encrypted.txt.  (A sample
> +		dracut patch, which loads the trusted/encrypted key
> +		and enables EVM, is available from
> +		http://linux-ima.sourceforge.net/#EVM.)

As long as you're changing this, let's update it to reflect that both
dracut (97masterkey, 98integrity) and systemd (core/ima-setup) have
this support.

thanks,

Mimi


> diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
> index 2ff02459fcfd..abbe8f4302ed 100644
> --- a/security/integrity/evm/evm.h
> +++ b/security/integrity/evm/evm.h
> @@ -23,6 +23,9 @@
> 
>  #define EVM_INIT_HMAC	0x0001
>  #define EVM_INIT_X509	0x0002
> +#define EVM_SETUP       0x80000000 /* userland has signaled key load */
> +
> +#define EVM_INIT_MASK (EVM_INIT_HMAC | EVM_INIT_X509)
> 
>  extern int evm_initialized;
>  extern char *evm_hmac;
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index c8dccd54d501..c7bc38a7ca94 100644
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
> @@ -61,24 +61,27 @@ static ssize_t evm_read_key(struct file *filp, char __user *buf,
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
> +	}
> +
> +	evm_initialized |= (i|EVM_SETUP);
> 
>  	return count;
>  }
